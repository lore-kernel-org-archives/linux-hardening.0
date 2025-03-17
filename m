Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7225B1459F7;
	Mon, 17 Mar 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217590; cv=none; b=X+xtFroGyB2dtdstv8PrIM637qQh0qObcxITmIbsNjVmCnoxxNqiKBKPTn2nTs+4ZVZ4XDG8JlIMa/I8vDhcAXIqN2QnW46iVH/KGS0awgjyc2CQJgVPEAe3gNklWnb9yXa9xBYXnWltSLakxdV47TJkgcaxraI0u5eKDZHUQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217590; c=relaxed/simple;
	bh=uzJkhwFZP+NIbO8Sk3ffx/0jNKk3BJTzkKsNHU7Ed+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCUl9vK5ALBu3SDpMTYFdip73RYoREFKijQIIny/1ii/31K5H2aadkL9T9+75sJ+XZ8Nh8AhFt55CvVgJSYR72nerCAqXqiSwr2ogB5Mi+a3TZLKnMja2n0o5pP7wnaAaRbdXbwm9fZVxqw2ZH+QGNRJZv3bCnoZa9j+GIav8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ce5x/Msu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ce5x/Msu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9jiv6002902;
	Mon, 17 Mar 2025 13:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uIBStIowzeJ2a8070lw6NfzHvbcoayyrjyCJG4QA4
	sI=; b=ce5x/MsuizY87udEtbvc6wp0AXQNc1FFNOYKxrtuj90jtVYzTyeaPsV8J
	lR6z9V6uHJvnL2t8SBN/093aOFyKsaHSRB3uRIBhH4q70D2jvfSSe8KQbFflnv4F
	h0TAaJEUAHutr9+uZXFbS4600fS9h76qn3+iIkcjhWuZxwpejW7zqmx7yDwLD02v
	70x5KyhQBaO1ka1nqCZrNAb3/6B2mZAKgO6h6vpbf9qlM8+zG6rWkiSWkR1MbR10
	N7sHJdpsluag0b8TFZDjdSf8Q+g5SPXo3ON0A+UUZK0bjGesoESqq4k9o4no3Ae5
	ivRPfT1Eo9DWJk4z9mGEDgyFAaLRg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5v03h3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 13:19:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52HBfPdR032373;
	Mon, 17 Mar 2025 13:19:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvt6h25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 13:19:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52HDJIdp32506380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 13:19:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD282004B;
	Mon, 17 Mar 2025 13:19:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F294120043;
	Mon, 17 Mar 2025 13:19:17 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Mar 2025 13:19:17 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <kees@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] mseal sysmap: update supported architectures
Date: Mon, 17 Mar 2025 14:19:17 +0100
Message-ID: <20250317131917.1332402-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: szFjiLkzdeAlafvFhq-dTRymfMvuYSW1
X-Proofpoint-GUID: szFjiLkzdeAlafvFhq-dTRymfMvuYSW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_05,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=663
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170095

Add s390 to the list of architectures which support mseal sysmap.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
    Andrew, please feel free to merge this with "mseal sysmap: enable s390".

 Documentation/userspace-api/mseal.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 56aee46a9307..1dabfc29be0d 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -143,7 +143,8 @@ Use cases
   the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
   architecture.
 
-  The following architectures currently support this feature: x86-64 and arm64.
+  The following architectures currently support this feature: x86-64, arm64,
+  and s390.
 
   WARNING: This feature breaks programs which rely on relocating
   or unmapping system mappings. Known broken software at the time
-- 
2.45.2

