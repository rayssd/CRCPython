import boto3


def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    MyTable = dynamodb.Table('MyTable')
    return updateDDBItem(MyTable)


def readDDBItem(MyTable):
    response = MyTable.get_item(
        Key={
            'Visit': 1  # reading the value(s) of primary key ID 1
        }
    )
    return response['Item']['Counter']


def updateDDBItem(MyTable):
    response = readDDBItem(MyTable)
    value = response + 1

    MyTable.update_item(
        Key={
            'Visit': 1
        },
        ExpressionAttributeNames={
            "#callitwhatever": "Counter"  # has to have a # in front of variable name
        },
        ExpressionAttributeValues={
            ':randomval': value,  # has to have : in front of variable name
        },
        UpdateExpression="set #callitwhatever = :randomval",
    )
    return value


# print(readDDBItem(MyTable))
# updateDDBItem(MyTable)
# print(readDDBItem(MyTable)['Item']['Counter'])
