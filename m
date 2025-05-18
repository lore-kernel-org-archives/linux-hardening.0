Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB5EEDE;
	Sun, 18 May 2025 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747541470; cv=none; b=CczDinXzWUInsUHNO6HLudFWaUzj9cNI8di8j9OtOwpC6Jgw2b/WQCjKUN3+4tEq4+ynE5CvQRP20WwCqQvwy8Um72pfmUMH1FuEKWOAuZ4df8D8PnYOpS1M2zVeomZZAVZd3n8+lXxvYdV1EARm7i7vrLRe4Y9uVO5EwfGsHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747541470; c=relaxed/simple;
	bh=AdwzIP8/uuMxgy2PzsepCvdsrmVIW2mO3UxQvOEbPO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lvjx5zgs3cGle1ULIWXhl/dOHOISM6kmoxlpZB5QvSPB06AH4FP930ShNKbJIRBH0Ly2ApNhksoyXDDwbtfR7bluj7szm6H+Xk+7WPs5RGOsYyfevoL751bIZJpDb6hUAB5CKm/zxCq9PZHC2Qt3Mrc8UPXk7jR4NDMay8wEZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jXmwgWw5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jXmwgWw5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54I20P2i013585;
	Sun, 18 May 2025 04:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lZr01G
	mqW9FsJmFstYGZZlQSl2u2zNrJtPHT928qRvk=; b=jXmwgWw5rSQFfbF5VGlFTQ
	BZED1ifx4KQht17bODgPH73zORx1RiKckhRjJmUAkM3B+mOfVAKEPOwd2p6ot+sS
	l6ru9FZJEHCtg1Fe1tJE549z1G7XASDqrE+f8SO8hE/LB5Wtycv5TeoTA6oJe+X8
	hPWjnFa7p84tDFBquTQz/Kcw+80b/69gqEhyJp5JCVNHH1N45Bef4PDfPBcKhgLH
	9/YrFP0J3/8WJnuyk1mAJSuMdmHeuYkYZnHQ/RFL7NkFrXODhItO5ly0HKQXy1wf
	7wJUdSXCqZ49+i84HAfTIkrm+C5STrw/uaIPfcvSE1a0C7U0OFCsa3pBjuj4p7LA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46pn2sb9rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 04:10:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54I4AXsT024560;
	Sun, 18 May 2025 04:10:33 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46pn2sb9rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 04:10:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54I3FMlI016070;
	Sun, 18 May 2025 04:10:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q7g20563-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 04:10:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54I4AVda45220270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 May 2025 04:10:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A34EE200BA;
	Sun, 18 May 2025 03:45:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 855FB200B3;
	Sun, 18 May 2025 03:45:04 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.51.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 May 2025 03:45:04 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Replace strcpy() with strscpy() in proc_ppc64_init()
Date: Sun, 18 May 2025 09:15:02 +0530
Message-ID: <174753967075.24504.4269062328317378824.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421183110.436265-1-thorsten.blum@linux.dev>
References: <20250421183110.436265-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDAzNCBTYWx0ZWRfXx/zOcLDG91Ed IEEgr3xxtD+i4n+eek2esBuXvLfm86CSuCKfZEImltjgSe9bd5Z99kDAVGDjYs+Zi8qGblAwp9t H6ved9YS3zSKqWTz/lL+5DyF7XM9zRzAdzWKi83Sd3tgS622eGrtv2OgwyW6zj/D5hefIo2JM/m
 TOBTYUlNKbV1LpG/yxAblIMFZ93TDhzwQCIFPjINJsbMo+0L/cQHwxf8e94AH/F74QLf+RcdQ8L RxToVbSnos6XVBzX5VjzjniPGqEYK+JTgp0aNQPnJV1EJ7QuV4bznOozX37P9fp6Vfh06a+QUpy iqJTUtnBFnfcVid69lIjkhgUCoWzSmgP5yBRcH/NWRY+Hoaywz0GDPKZa0JFt33loNaftxcfs5t
 NSNDymeGH6gcWKOkbCjR5XS9Q9E7uES/FkBouKUHjRrvW7WX+OWK6CrpP8S0wAfzGehYsoGn
X-Proofpoint-ORIG-GUID: dBHuUcMunzL_RAR4C-1ueT5IMf6FvjuC
X-Proofpoint-GUID: jv_TqUPimTSwFXqO-AStKCjPLWwjZrVC
X-Authority-Analysis: v=2.4 cv=GYQXnRXL c=1 sm=1 tr=0 ts=68295dba cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=Uu9fRxi0hxKbv0zXlPQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=691 bulkscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505180034

On Mon, 21 Apr 2025 20:31:08 +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Don't cast the destination buffer from 'u8[]' to 'char *' to satisfy the
> __must_be_array() requirement of strscpy().
> 
> No functional changes intended.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Replace strcpy() with strscpy() in proc_ppc64_init()
      https://git.kernel.org/powerpc/c/7e99a4a60d8fc9b24a3f9632011bf7e197f1aff9

Thanks
