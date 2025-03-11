Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91D254872;
	Tue, 11 Mar 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696470; cv=none; b=pSFZo8ZQg0epwCTL5wt4dnvWVmqZldCJS7utvAqq/Fa2TRAQj5irb2AtmfCbocrTJQ1MiBQYOEdD6RQ67Y4jfttxVi72mNsncMmn9OuZiaOSKGrQxzyZscB0QYdzuOxwrfEnVJOwZeMnyAOZj2383iBn2GSDBW+dkwRZB9DvW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696470; c=relaxed/simple;
	bh=8/+ZzYY60s5cddI9gvuPDMhVzdRjpqDCvgMdRpdiu0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCKWulE0knTl+0vX7rD/WYXVUys1owK+Qg9EdjNK8usAHMoqmvfq2ua4aGcwySAJYuxOjKAJPksJ3q4t4Mch7EfljHiGZEHY2hsLBb8um3vC9XaoiZ4Nd9OfyUXbU/X/7XL+urmxw2soC/WrBUCz3LlgqkqV14mavrfOrWHEOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LPVPf3Hb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LPVPf3Hb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7nWnK002292;
	Tue, 11 Mar 2025 12:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zscoAtZKprUXrnSOM
	/SgUnaPvlWAThLsgYpYN8Ztt+Y=; b=LPVPf3Hbi0J07fKFg2zruWoQEm1Qvtjz/
	jCDG88hpTdJp6c939G7iGpOGDsaY0HW5zm1fX70aVgdL+mTPSl9OBc0IW5rO3e2G
	wITyK7T/KLfl91axl+euT6Tx8rEepe6HRo76vjeZaBg8uC88xGmJCAnViyDwmnT3
	6+WRwvZ6apQvGL04Ohk2wfwjWYndjXcSq3V9x7dSPkhsOW7bbouaxJmzPt02LK+n
	dSGIADmCkcwcA/zFOc01RFoS39eXLiah5W6G5tKOnxEtRjYH8/HgO0wDdOfFM4A5
	DXK5Tw3QNV+1PjsvawaActpsPAiXp2iEsX0aONS+hWGsYqac+gUyg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a7g5uque-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 12:33:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BA1O7I027566;
	Tue, 11 Mar 2025 12:33:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkm2jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 12:33:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BCXRLr37028186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:33:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D69B42004E;
	Tue, 11 Mar 2025 12:33:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62F3F2004D;
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
Subject: [PATCH mm-unstable 1/2] mseal sysmap: generic vdso vvar mapping
Date: Tue, 11 Mar 2025 13:33:25 +0100
Message-ID: <20250311123326.2686682-2-hca@linux.ibm.com>
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
X-Proofpoint-GUID: MxwBgJQM4sBjzJFJ2-JrRCRRAnWtOPgo
X-Proofpoint-ORIG-GUID: MxwBgJQM4sBjzJFJ2-JrRCRRAnWtOPgo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=862 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110080

With the introduction of the generic vdso data storage the VM_SEALED_SYSMAP
vm flag must be moved from the architecture specific
_install_special_mapping() call [1] [2] which maps the vvar mapping to
generic code.

[1] https://lkml.kernel.org/r/20250305021711.3867874-4-jeffxu@google.com
[2] https://lkml.kernel.org/r/20250305021711.3867874-5-jeffxu@google.com

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 lib/vdso/datastore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index e227fbbcb796..b7c7386c98a9 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -99,7 +99,8 @@ const struct vm_special_mapping vdso_vvar_mapping = {
 struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned long addr)
 {
 	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
-					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP | VM_PFNMAP,
+					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP |
+					VM_PFNMAP | VM_SEALED_SYSMAP,
 					&vdso_vvar_mapping);
 }
 
-- 
2.45.2

