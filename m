Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1F235374;
	Tue, 11 Mar 2025 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696433; cv=none; b=sHrUskXBTmww5RUJt4fSfwCuKpKQKWJnXT97zWpWefZHT/q3jRlKBvBXbri5yuWSYucTZ6eKDZfb1kd/DQsuDHk+Sc2vcCADzHFkgZjI8t9UA2PDAoz40ov+nGbiAqiS6HfWHv12folEdGRsyDtoyBpsAd0XVFsmhchTWvwhkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696433; c=relaxed/simple;
	bh=/ZqH/OzJhJybXtGvfJ2LdQDVARslJXhZ1jNu4St5Lfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htgUXWj73Yo4xpirGp8VvGFG5/5fYzZsdjCJA4Isswo0uqNYOD/7HGrJvbsImbx/18GpZq6vZj/UaEVC68lCbOG5UGGwD3c+JrUhK62IyA5WSKXlpqCKMtIFUiY3C+9Q43PotCnnsmMr25WR/VifY45kvzcAtn1OaYCjT8IpfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ea1vYaNg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ea1vYaNg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9P46v001921;
	Tue, 11 Mar 2025 12:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v7NwAy9lYADasK3AR
	PRjsggbKrh0vi/90nC9hkllay8=; b=Ea1vYaNg9p7tyO4znc04katnb6MEDwRfw
	BNIbA9mpOlgOs2r5qGv9kujNCiPmD3Jc89ezpE9fk/VqW7jppQM5f0EIxlYG6JkM
	3kQ73OB9NdnjiI/Ufx77zWbiA6TkeO7aF5ZoArzIzqs77Gfo6dvSkEJTI5AhOM2x
	jp3W4zmTl8K4pCKKEgCeRYn7rgfik+9I1fLh4ryOIvfjLPW8ts9bZ1q84TJMGVM2
	fzePj6H+x5JEYLyjZHRdkaBFKubk3nbB8USYa2Itcq8R/84IsypuE9YCLvZGJTUJ
	eXyRMDCKqzGQuPtAM0C+KmswZmzoAHEOlj2cKC6gPEx7cqhvhZm4g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a7g5uquj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 12:33:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9g32P022223;
	Tue, 11 Mar 2025 12:33:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45917nc4k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 12:33:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BCXSit58982866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:33:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB222004B;
	Tue, 11 Mar 2025 12:33:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E600D2004F;
	Tue, 11 Mar 2025 12:33:27 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 12:33:27 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <kees@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH mm-unstable 2/2] mseal sysmap: enable s390
Date: Tue, 11 Mar 2025 13:33:26 +0100
Message-ID: <20250311123326.2686682-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250311123326.2686682-1-hca@linux.ibm.com>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MtQCe0fUy6IfEAWGegeAn-LxBAPpKsgg
X-Proofpoint-ORIG-GUID: MtQCe0fUy6IfEAWGegeAn-LxBAPpKsgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=756 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110080

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on s390, covering the
vdso.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig       | 1 +
 arch/s390/kernel/vdso.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 608a965e2344..93b880992596 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -141,6 +141,7 @@ config S390
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
+	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 70c8f9ad13cd..430feb1a5013 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -80,7 +80,7 @@ static int map_vdso(unsigned long addr, unsigned long vdso_mapping_len)
 	vdso_text_start = vvar_start + VDSO_NR_PAGES * PAGE_SIZE;
 	/* VM_MAYWRITE for COW so gdb can set breakpoints */
 	vma = _install_special_mapping(mm, vdso_text_start, vdso_text_len,
-				       VM_READ|VM_EXEC|
+				       VM_READ|VM_EXEC|VM_SEALED_SYSMAP|
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
 				       vdso_mapping);
 	if (IS_ERR(vma)) {
-- 
2.45.2

