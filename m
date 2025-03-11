Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E148241682;
	Tue, 11 Mar 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696469; cv=none; b=E5yUnEby4QrEgocibcouXqn4uiClqBPtMctHai3ekpElx7OXYWuk2EZEJ3WFj3ybMB323Pldqlm7j0NdLlm/b9KajhYAdyzL3BQl4EBV1qoZjZgLkdUrJCm1AZKsC4WJdHFOCZEVq5tLBHY+ijzGk/Mk/KbKm3Y5puS3uHcR610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696469; c=relaxed/simple;
	bh=3nSeGjR2LRHQUTGL1OW3XfGyRxmNFSpIYqZ3BQVOSvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOQvP97/ubTF4xY4p6VtElZO7RA0gocawjNB20NMANQ7G8SO/VAcUBp6b9fsV5pgfpj3nz3YK/k6QgYghOULJSNQ6eJBxD2UdIrrNvAR7nZYSc566k367KCQH6DzjfUCYkQH/NPSNR7UI+r1ZpFR/R85Mdz9obztBUlbSE4FBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Li47Gwkj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Li47Gwkj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCShMn029496;
	Tue, 11 Mar 2025 12:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=U7g7+PfQ3H9C/hSbI3ABdnYmVgectOIMQFe+/I4vY
	sc=; b=Li47GwkjwXkji/uij1GDtxWIr4ljIHiCxJBl3Y6fAn6Oz+Lo/PGtooN+g
	gSPElXiyzSzv8L36Jubv1h4eoiDWOKOlbqMNQUn30mLEiSgS7pA8W0qk4x4g2FB9
	Ko4m7WNL1m9JNHS41PNySXXjMUpJ/aRQwWjAo12UWhAowX5VceyOE6k98WKI2Fjg
	VDHUoFISCgK/xCSZEIVibucM+9bcYCkBJOsf8VMSnl6vezQRUe0+mwkxmFIUtAIO
	f+/XO2SaZ4A9SfLU52MGAmg+4zPSbrksywWIe7UayV0TAuaPmycu2+ngpDb2XlzF
	WwmNzZzJ12PgZ0bK4s7DrnrYfL4zg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45an7bg0qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 12:33:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B8o3ju006982;
	Tue, 11 Mar 2025 12:33:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45907t4b7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 12:33:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BCXR0j37028184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:33:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 565D22004B;
	Tue, 11 Mar 2025 12:33:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7D0620043;
	Tue, 11 Mar 2025 12:33:26 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 12:33:26 +0000 (GMT)
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
Subject: [PATCH mm-unstable 0/2] mseal system mappings fix + s390 enablement
Date: Tue, 11 Mar 2025 13:33:24 +0100
Message-ID: <20250311123326.2686682-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FZ58v51MTbKQnsn9kFpmKloyYy9x14NB
X-Proofpoint-ORIG-GUID: FZ58v51MTbKQnsn9kFpmKloyYy9x14NB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=394 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110080

When rebasing the mseal series on top of the generic vdso data storage
the VM_SEALED_SYSMAP vm flag for the vvar mapping got lost. Add that again.

Also add s390 support for MSEAL_SYSTEM_MAPPINGS.

Heiko Carstens (2):
  mseal sysmap: generic vdso vvar mapping
  mseal sysmap: enable s390

 arch/s390/Kconfig       | 1 +
 arch/s390/kernel/vdso.c | 2 +-
 lib/vdso/datastore.c    | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.45.2

