const express = require('express');
const app = express();
const port = 3000;
const path = require('path');
let publicPath = path.resolve(__dirname, 'public');
let AWS = require('aws-sdk');
AWS.config.update({region: 'eu-west-1'});

app.use(express.static(publicPath));
app.get('/appCreate', appCreate);
app.get('/appDelete', appDelete);
app.get('/appQuery/:year', appQuery); // in case no prefix is included
app.get('/appQuery/:year/:prefix', appQuery);
app.listen(port, () => console.log(`App listening on port ${port}`));

const S3_BUCKET = 'cs4000-a2';
const S3_OBJECT = 'moviedata.json';
const DB_TABLE = 'movies';
const BATCH_SIZE = 25;
    
let s3 = new AWS.S3();
let dd = new AWS.DynamoDB();

async function appCreate(_, res) {
    let tableExists = await checkDynamoTableExists(DB_TABLE);
    if (tableExists) {
        res.json(generateResponse(false, 'Table already exists', {}));
        return;
    }

    console.log('Creating...');
    let json = await getS3Object(S3_BUCKET, S3_OBJECT);

    await createDynamoTable(DB_TABLE);
    await dd.waitFor('tableExists', { TableName: DB_TABLE }).promise(); // wait until table has finished creating
    await insertIntoDynamoTable(DB_TABLE, json);
    console.log('Done!');
    
    res.json(generateResponse(true, 'Creation successful!', {}));
}

async function appDelete(_, res) {
    let tableExists = await checkDynamoTableExists(DB_TABLE);
    if (!tableExists) {
        res.json(generateResponse(false, 'Table doesn\'t exist', {}));
        return;
    }
    
    console.log('Deleting...')
    await deleteDynamoTable(DB_TABLE);
    console.log('Done!')
    
    res.json(generateResponse(true, 'Deletion successful!', {}));
}

async function appQuery(req, res) {
    let year = parseInt(req.params.year, 10);
    let prefix = req.params.prefix ?? '';

    if (isNaN(year)) {
        res.json(generateResponse(false, 'Invalid year', {}));
    } else {
        console.log('Querying...');
        let data = await queryDynamoTable(DB_TABLE, year.toString(), prefix.toLowerCase());
        console.log('Done!');
        res.json(generateResponse(true, 'OK', data));
    }
}

/* Helper functions which use the AWS SDK */

async function checkDynamoTableExists(tableName) {
    let data = await dd.listTables({}).promise();
    return data.TableNames.includes(tableName);
}

async function getS3Object(bucketName, objectName) {
    let params = {
        Bucket: S3_BUCKET,
        Key: S3_OBJECT
    };
    let data = await s3.getObject(params).promise();
    return JSON.parse(data.Body.toString('utf-8'));
}

async function createDynamoTable(tableName) {
    let params = {
        AttributeDefinitions: [
            { AttributeName: 'titleLower', AttributeType: 'S' },
            { AttributeName: 'releaseYear', AttributeType: 'N' },
        ],
        KeySchema: [
            { AttributeName: 'titleLower', KeyType: 'HASH' },
            { AttributeName: 'releaseYear', KeyType: 'RANGE' }
        ],
        ProvisionedThroughput: {
            ReadCapacityUnits: 5,
            WriteCapacityUnits: 5
        },
        TableName: tableName
    };
    await dd.createTable(params).promise();
}

async function insertIntoDynamoTable(tableName, json) {
    // DynamoDB only allows batch inserts of 25 items
    let batches = [], batch = [];
    for (var i = 0; i < json.length; i++) {
        if (batch.length == BATCH_SIZE) {
            batches.push(batch);
            batch = [];
        }
        batch.push({
            PutRequest: {
                Item: {
                    titleLower: {'S': json[i].title.toLowerCase() },
                    releaseYear: {'N': json[i].year?.toString() ?? '-1' },
                    title: {'S': json[i].title },
                    rating: {'N': json[i].info.rating?.toString() ?? '-1' }
                }
            }
        });
    }
    if (batch.length != 0) batches.push(batch);
    
    for (var i = 0; i < batches.length; i++) {
        console.log(`Inserting data batch ${i + 1}/${batches.length}`);
        await dd.batchWriteItem({ RequestItems: { [tableName]: batches[i] } }).promise();
    }
    
}

async function deleteDynamoTable(tableName) {
    let params = { TableName: tableName };
    await dd.deleteTable(params).promise();
}

async function queryDynamoTable(tableName, year, prefix) {
    let params = {
        ExpressionAttributeValues: {
            ':y': {N: year},
            ':p': {S: prefix}
        },
        FilterExpression: 'releaseYear = :y and begins_with (titleLower, :p)',
        ProjectionExpression: 'title, releaseYear, rating',
        TableName: tableName
    }
    
    let raw = await dd.scan(params).promise();
    let data = [];

    raw.Items.forEach(function (item, _, _) {
        data.push({
            title: item.title.S,
            year: item.releaseYear.N,
            rating: item.rating.N
        });
    });

    return data;
}

/* Other helper functions */

function generateResponse(_success, _message, _movies) {
    return { result: {
        success: _success,
        message: _message,
        movies: _movies
    }};
}
