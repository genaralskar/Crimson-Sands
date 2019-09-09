using System.Collections;
using UnityEngine;
using Vector3 = UnityEngine.Vector3;

public class PooledObjectSpawnerTest : MonoBehaviour
{
    public GameObjectPool pool;

    public Vector3 baseVelocity;
    public Vector3 randVelocity;
    public float fireRate = .2f;

    private void Start()
    {
        StartCoroutine(SpawnProj());
    }

    private IEnumerator SpawnProj()
    {
        while (true)
        {
            GameObject proj = pool.GetPooledObject();

            proj.transform.position = transform.position;
            proj.transform.rotation = transform.rotation;
        
            proj.SetActive(true);
        
            Rigidbody projRb = proj.GetComponent<Rigidbody>();

            Vector3 randVel = GetRandVelocity();
            Vector3 vel = baseVelocity + randVel;

            projRb.velocity = vel;
        
            yield return new WaitForSeconds(fireRate);
        }
    }
    
    public Vector3 GetRandVelocity()
    {
        float randx = Random.Range(-randVelocity.x, randVelocity.x);
        float randy = Random.Range(-randVelocity.y, randVelocity.y);
        float randz = Random.Range(-randVelocity.z, randVelocity.z);

        Vector3 randVel = new Vector3(randx, randy, randz);

        return randVel;
    }
}
