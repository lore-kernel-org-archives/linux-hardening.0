Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B23CFF4C;
	Fri, 19 Jun 2026 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781906454; cv=none; b=EB790FvIDiFy0XDo7Tlmdnk22U20hGH0VJIvSPGAQp4ABVe5fhPeSUFsqbM+cvr/f7121gdTFgYYayJpnYsb5T9OxXgXa56Wh5iZYsUOzOA6XI6NQI1mN+8Fs7alEhHVYqIzDWwjHxS7IzfuNDmTFJ9BBedE+7tDAejxXhQjo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781906454; c=relaxed/simple;
	bh=KAtfuRkM4ySqjBYKGFxhPKkDAQVRpACqT220bifabdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXIvMRPrNChHHILZbdcHvnWjM31z3iS/dAHB8xPFpXozAfD1kmxMCkH5LTwzUcK6sTueUaDcUUBfgpOh8r3iEOr4QUhOPJlp2XAvXNaW3Q9feupM9xaao6Ytv3cCz7hEfjnd5sG74stFYF68e0mi+h8fVOFiNKx9s/PrqA02UHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jTk/Hu/r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jTk/Hu/r"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmGTv3445137;
	Fri, 19 Jun 2026 22:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0Ye5dh
	shwXr58VxzYRx5kr1b+nZcAXsMCPw9rovgVX8=; b=jTk/Hu/rTkgfyVojxBEsZF
	LrXddMMTee/PiT9A2pSNsJoHpjxpltopqhBEzYk8ZqJ1b5csYRYVj9M56xg2Gntj
	+Bw21MzhnQkrmDhXS8vrKrw72Zygehyls5Ean1aSOBqtyEjwPEmY8woz9xj4xwtN
	Wcc9tTN4CwJhTRuidhh8O5JDRyx6q08cyPBELxkcvL7wWyCfXP65DIljwON+6n2T
	JsCa9AbFsoC3tHCIriozAxIU5+7DBTGc3Us8cwzAHqyF+k+KAe7J8g141Ku0neJY
	vLJy6na6069zCqzVdFZOhVRl5+eH2u/eP8UH5JE9d/C+NPtEQLrOzWXz/XpsqNvg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw7rwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnh6h007545;
	Fri, 19 Jun 2026 22:00:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM0Xp830343760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6475520040;
	Fri, 19 Jun 2026 22:00:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5760220043;
	Fri, 19 Jun 2026 22:00:31 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:31 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Christophe Leroy <chleroy@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/lparcfg: Replace deprecated strcpy in parse_system_parameter_string
Date: Sat, 20 Jun 2026 03:30:12 +0530
Message-ID: <178190618802.653308.14345935745182583416.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20251013135703.97260-2-thorsten.blum@linux.dev>
References: <20251013135703.97260-2-thorsten.blum@linux.dev>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX+d4X9phUmC2C
 KYwyG4LptMezMrtxROxSa/iHzvmyD7/aBChh+f0LJPCumKPxMNRAKVGGWz9EVsdH/8cKcg9nnyl
 x88VukTTYgoGkEoSSVPhmaH1ATacrLg=
X-Proofpoint-GUID: 0Mw86DZJdEKxSCzY2d6cDJ68WtHC3z51
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a35bc05 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=ObQ0Zf3V30G6lmXZe-cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3G9r9qoivLZVygOWlLIB9JecMtJ-RsSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfXwyXN5OPmGF2X
 8ADPqnC75eKmSbMBrsmQIyuJJ/V0Y6XaWxYM7qrQlDAIOZNG3OMbEGeMUFgh9Gw1rkMceRWFUAg
 N95dZ1qztvcz/acplP6ZUryzZ0sSMeAtTy8hnNlnkkzW3devJUdy9NbOvM/sheMDHGLYO0C/q7E
 TELga004Gfuu+JWREVSUWnQBS02fHqNW1D93KvyX8mmvzt3PIkACkWBkWwS2vrjSKBFIigJILgD
 caFzzNfxCYANpc8RlC55I5aTbYykHqWQ1Z6fW3uafwbY6mwcwNm7rJiQiiDvYWRIBzGH4SfJDmV
 L4DcCYPDtmCzyfiU30GnNgSKAVDpNfoA+nX7ODyvPsLkno8Btd92LqmzRYNkPz+luP17M/2i84r
 OnShStqGznv0U2zcRIzbk9SJLydDadKnvxoO7GEN+Kg2JDjkgPibfoC4lookDNhDASAaq6qbpq8
 +jl/53WDyowkhL2jzRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Mon, 13 Oct 2025 15:57:02 +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead. Use the return value of
> strscpy() instead of calling strlen() again, and ignore any potential
> string truncation since both strings are much shorter than the buffer
> size SPLPAR_MAXLENGTH.
> 
> Change both if conditions to silence the following checkpatch warnings:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/lparcfg: Replace deprecated strcpy in parse_system_parameter_string
      https://git.kernel.org/powerpc/c/c8f80f95da32618d49c2a068ee561b85655b761d

cheers
