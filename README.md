# calculator java maven jenkins CI pipeline

## Junit test cases

```
public class AppTest 
{
	@Test
	public void testSum() {
		App calculator = new App();
		int result = calculator.sum(2, 2);
		if (result != 4) {   // if 2 + 2 != 4
			Assert.fail();
		}
	}

	@Test
	public void testMinus() {
		App calculator = new App();
		Assert.assertEquals(0, calculator.minus(2, 2));
	}

	@Test
	public void testDivide() {
		App calculator = new App();
		Assert.assertEquals(2, calculator.divide(6, 3));
	}

	@Test(expected = ArithmeticException.class)
	public void testDivideWillThrowExceptionWhenDivideOnZero() {
		App calculator = new App();
		calculator.divide(6, 0);
	}
}

```

## Maven Build stages

```
stage('Maven-Clean'){
      steps{
        sh 'mvn clean'
      }
    }
    stage('Maven-Compile'){
      steps{
        sh 'mvn compile'
      }
    }
    stage('Maven-Test'){
      steps{
        sh 'mvn test'
      }
    }
    stage('Maven-Package'){
        steps{
        sh 'mvn package'
        }
    }

```

## Sonar analysis

```
stage("build & SonarQube analysis") {
            steps {
              withSonarQubeEnv('sonar-server-local') {
                sh 'mvn clean package sonar:sonar'
            }
        }
    }

```

## deploy to Jfrog artifactory after succesful build

```
  post{
      success{
          rtUpload (
            serverId: 'ARTIFACTORY-SERVER',
            spec: '''{
                 "files": [
                             {
                                "pattern": "target/*.jar",
                                "target": "art-doc-dev-loc/calculator/"
                            }
                        ]
            }''',
 
            buildName: 'sample calulator',
            buildNumber: '1'
            )
      }
  }

```

check full pipeline @ [jenkinsfile](https://github.com/sujjadshaik/calculator/blob/master/jenkinsfile)

