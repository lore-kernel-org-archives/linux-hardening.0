Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752BD495AEA;
	Wed, 14 Oct 2026 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969317; cv=none; b=djtoBGmiT2fI5G9DUw9h1+h2liWNxyb+dMI+tXZP+wlOiZ1FRhT7wy8YHQN3768gg61G4vBzpYWQmNi4rqEFrf/n1iCUroAq//Fg5jOkRKEDTfDTgCJxPFhd3jR6m1VeNG6kolWnzF3AJ5agU/Rr3H/LR8MYUIM7CjEdUD2F3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969317; c=relaxed/simple;
	bh=ejpOPsT3Vo9EC/O9DbjVbaZzp+M1tuNcFAofLpi5fNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kql4znDVgysZtAG1VSyw40kCiZF6Wb/65s0W5JWlL/WLaKcp3yDkFnJXYrbZcbUlqUzxnTrzr1eyjDHzFJSQCgPv+9VI7+mbchZmIm2CjOcSQadkZcn2ye+7RRptet0uACcRzF9GRoSLPgej+ReX1HLsfdqvpK00psWqPAxYpsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E7GR231/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E7GR231/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DLrRYi151645;
	Wed, 14 Oct 2026 09:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kBJN2s
	n3LruxPVXU18hO38XqF6w4ZhlquYkjmoaFgoM=; b=E7GR231/UYhPA9nnETsS4Q
	M/7hcI1quYujk/UjMHPUWbT29zEOEGYLgRERTajniloLYDlA1JWNsEdMrNYQGMOg
	ro5/EsaVhTA9Mh+ywTtXSTKAaecdGUyNaBobxzzVE6sYkzsUOc3jJQdX3FnAjZOz
	QimGkwCfVPWgSuCzzBDUcUIEB2SIkajhrmR3pzDpfP4qaCyc8FFxUEfj4BC3Ugif
	+LEm1aRqfoyG5joAT8iJHAnILFffgF+YTYa0hi1oQSw+OV9inxpVprTOX7lvbIOr
	rA3ai9bkNdFufbuaJDiDNw8KeY+gE5FccsOZgds6BNQ8DNjJCHMm7mL2q8ycTWyw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhkgfv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 09:14:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E6vmhC3304246;
	Wed, 14 Oct 2026 09:14:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6v1x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 09:14:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E9EqUL31523504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 09:14:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D569D20043;
	Wed, 14 Oct 2026 09:14:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B794720040;
	Wed, 14 Oct 2026 09:14:47 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 09:14:47 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, kees@kernel.org, mahesh@linux.ibm.com,
        nikhilks@linux.ibm.com, amachhiw@linux.ibm.com, sayalip@linux.ibm.com,
        robh@kernel.org, mkchauras@linux.ibm.com, kasan-dev@googlegroups.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V4] powerpc/kasan: fix r2 corruption in mem*() on GENERIC_ENTRY with old compilers
Date: Wed, 14 Oct 2026 14:44:46 +0530
Message-ID: <179196918691.1557523.109435781185152788.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003094006.3404731-1-mkchauras@gmail.com>
References: <20261003094006.3404731-1-mkchauras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX8D2a4T/60reo
 EtKSPHm8PerE2w0n8XS/no08kB0xsauw71h3IEY9kgUzKU/5VB8nhS0E8/sCvxYPcfY/0RhbXxt
 Zr8w0p1b1RC+MVt5GwcRb18aio4yKJI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfXxcWVBOQmwWGx
 rKKbXLLI94AqOC+/W9rCsGN5z9Yr/Q3OzFmy5S8vOnpEi2hjZlXpXIYPYtZ8umOF1/q3ARkn/FP
 qU+E7OPOAfEFygYknS529rwtJmnybH6YZwnVRkfvFT59hbeYEOKeCCtHaQ8i1JPpu/+dnYwEqY6
 wiI6sh5wcjc8ZznkCqXXT4acf7wbpq/5EQxqlBt3YglwmQH/AeDYtfLndgiizVRRwZGd8ZbZVtR
 w/G6vKGqN4YilvgCXOsg33fhusyH1Ec3Tf87hVpA1PGO7Wjz0O7aBoHNpYmP9zRw3iWRhHoQvEA
 MSJg+IvvUE6gbfSzO2UYHxUl9q1BS89/2M1zaBchKOa1MwW9tBT3kUMyOgfJSUDcL37btcRXQE7
 pGhyrctqLt0pqpz6YUNEfwPRpjys1cCc/4EgQXrSt0mmVdybRCP8q1P4ClqSHOuLO7/LXfo7kZB
 ve32yzJc1vD9rOxKfKA==
X-Proofpoint-GUID: 3j3Sme_meNSmuDlrgXE3nLoW07y6lRHm
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acf4811 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=PDSKOLl8Ch7aTm95IhAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uEGApIaRoVNhJCB4xy9wGvIWtmYDnFFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140036

On Sat, 03 Oct 2026 15:10:06 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") introduced
> a bug that, when CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX is not
> set, expand to two consecutive ELFv2 global entry points for the
> same function body:
> 
>   _GLOBAL_TOC_KASAN(memcpy) expands to:
>     _GLOBAL_TOC(memcpy);
>     _GLOBAL_TOC(__memcpy)
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kasan: fix r2 corruption in mem*() on GENERIC_ENTRY with old compilers
      https://git.kernel.org/powerpc/c/de5a7fedf5061bdf6823eb509353bd7c128e34b5

cheers
