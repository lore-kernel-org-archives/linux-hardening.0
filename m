Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60819E7C9
	for <linux-hardening@vger.kernel.org>; Fri, 14 Jun 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386787; cv=none; b=ambwOzDSmgRYv6f+eUENlk9XmVYeH7thqAFEAP8e9PUFXMMQSmnoP/kvCE8gF+OPWG1zbT6+8k97JNcZFx3Mv7s+COmAOyVCnO7UJg7eSdztxNhkAGaAH+IkzRwltVp9eJRqbmBv2IWE48FLp5cDEzhAN/o1caInqb0NbsbErWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386787; c=relaxed/simple;
	bh=fpjETf4EPj3vHyPCMjPTmh71Mrni8hAicFTS6ib+Oqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LaXBJ/dbSGFXvg8tMwZjkg18CEKarwxOMIB0HgDjEJp8675aGmhVIaxpaIp3iBI0Cnh6PUTnz+1exrtQcY0FudRJ4e0zMw0ZLLhdHS3YhAIPfffOHLi46hmUlljU/EME2lZtDVB1Ym9vEfP+3hAlw43OiuhixldFdlLrXiCfvEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OstekVL0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OstekVL0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EGRNHH021762;
	Fri, 14 Jun 2024 17:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=JarLK+H9YHM1Zny6ZNiJbVbWT4
	y5D2e9YGzp69fpAio=; b=OstekVL0JIISutJUPMIRIk4Sh79DOETcG5CXQkTxAK
	G0SmAj6xGosBHTsUmOuGVvOEDJ7+7wEcogt4rBBbHY4LkVKrd4Lib4uSNg6ivBEU
	LFLbIT93SV4NzVbJQ2gA6uZIUfJUz3MsIelfmp7q1G/mOObnmQiyb8GZEzcIDgS0
	o/QqkkRZu9wrOMzEkzsrsFaSYAg6RofOOQzsU32aidAUWzjVe38/VelI7Q5KzXB6
	6uKhHTWRdAhW+tc056WjrmDCnlDjoy7eKSOTsaz6OeYDJ1qjwyIdT5IrFjHq6VoH
	yZm8bqHFrGBz/hoheUj0FYC5ZKEm98bhzSS5CA0F0X0Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrqnp0ekd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:39:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45EHdW5U032650;
	Fri, 14 Jun 2024 17:39:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrqnp0ekb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:39:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45EGkwB7003886;
	Fri, 14 Jun 2024 17:39:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mqkhf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:39:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45EHdPSd41222590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 17:39:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83DD420040;
	Fri, 14 Jun 2024 17:39:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 548E120043;
	Fri, 14 Jun 2024 17:39:22 +0000 (GMT)
Received: from li-e43b234c-2c54-11b2-a85c-fec5a724df9f.ibm.com.com (unknown [9.43.114.155])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 17:39:22 +0000 (GMT)
From: Anjali K <anjalik@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, naveen@kernel.org, christophe.leroy@csgroup.eu,
        kees@kernel.org, gustavoars@kernel.org,
        linux-hardening@vger.kernel.org, anjalik@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH] powerpc/pseries: Whitelist dtl slub object for copying to userspace
Date: Fri, 14 Jun 2024 23:08:44 +0530
Message-Id: <20240614173844.746818-1-anjalik@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CQIPORYMi-k6bGTZEbZCY5ELSURUuSdG
X-Proofpoint-ORIG-GUID: VBux5JOupPYsr4cwbiUWRIxANVPOVWP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=526 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140119

Reading the dispatch trace log from /sys/kernel/debug/powerpc/dtl/cpu-*
results in a BUG() when the config CONFIG_HARDENED_USERCOPY is enabled as
shown below.

    kernel BUG at mm/usercopy.c:102!
    Oops: Exception in kernel mode, sig: 5 [#1]
    LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
    Modules linked in: xfs libcrc32c dm_service_time sd_mod t10_pi sg ibmvfc
    scsi_transport_fc ibmveth pseries_wdt dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse
    CPU: 27 PID: 1815 Comm: python3 Not tainted 6.10.0-rc3 #85
    Hardware name: IBM,9040-MRX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_042) hv:phyp pSeries
    NIP:  c0000000005d23d4 LR: c0000000005d23d0 CTR: 00000000006ee6f8
    REGS: c000000120c078c0 TRAP: 0700   Not tainted  (6.10.0-rc3)
    MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 2828220f  XER: 0000000e
    CFAR: c0000000001fdc80 IRQMASK: 0
    [ ... GPRs omitted ... ]
    NIP [c0000000005d23d4] usercopy_abort+0x78/0xb0
    LR [c0000000005d23d0] usercopy_abort+0x74/0xb0
    Call Trace:
     usercopy_abort+0x74/0xb0 (unreliable)
     __check_heap_object+0xf8/0x120
     check_heap_object+0x218/0x240
     __check_object_size+0x84/0x1a4
     dtl_file_read+0x17c/0x2c4
     full_proxy_read+0x8c/0x110
     vfs_read+0xdc/0x3a0
     ksys_read+0x84/0x144
     system_call_exception+0x124/0x330
     system_call_vectored_common+0x15c/0x2ec
    --- interrupt: 3000 at 0x7fff81f3ab34

Commit 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
requires that only whitelisted areas in slab/slub objects can be copied to
userspace when usercopy hardening is enabled using CONFIG_HARDENED_USERCOPY.
Dtl contains hypervisor dispatch events which are expected to be read by
privileged users. Hence mark this safe for user access.
Specify useroffset=0 and usersize=DISPATCH_LOG_BYTES to whitelist the
entire object.

Co-developed-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Anjali K <anjalik@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 284a6fa04b0c..cba40d9d1284 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -343,8 +343,8 @@ static int alloc_dispatch_log_kmem_cache(void)
 {
 	void (*ctor)(void *) = get_dtl_cache_ctor();
 
-	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
-						DISPATCH_LOG_BYTES, 0, ctor);
+	dtl_cache = kmem_cache_create_usercopy("dtl", DISPATCH_LOG_BYTES,
+						DISPATCH_LOG_BYTES, 0, 0, DISPATCH_LOG_BYTES, ctor);
 	if (!dtl_cache) {
 		pr_warn("Failed to create dispatch trace log buffer cache\n");
 		pr_warn("Stolen time statistics will be unreliable\n");

base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.39.3

