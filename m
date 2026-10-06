Received: from mx0a-00617f01.pphosted.com (mx0a-00617f01.pphosted.com [205.220.165.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BB2AD35
	for <linux-hardening@vger.kernel.org>; Wed,  7 Oct 2026 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791344187; cv=none; b=JhqNyVNkonFiXf9jGmdz9M5OeeNCFZQUA5iHIIvSpa/gN3yRsNKjKfkcgQ9rtiw7+xfAW7H9EaDjSahmjiODXCD1deWkyKwD+Jvqh5Su1y0qA3lH0F75fWygEFLBwzbwW8h8hi8PUkpGTcJT0OoVB0Qz5vNAvG1n7nlqcBABm3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791344187; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rPJ+IQESuoSCH/H3p8wAQaU/sZDYf8JJsATogVYLtxU6hb4OoM8puG8pML+O+0tXNX1+hg2I/ROzzUShyf6B3dHzcV23zDZ+5YV9bwmfRr9GwlFHdEl6g6dP4ydnEEO3xFRxmtoi1LObqAGCY27hO0ucI/Ydtr6Kg4XuW02TX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com; spf=pass smtp.mailfrom=psmicorp.com; arc=none smtp.client-ip=205.220.165.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psmicorp.com
Received: from pps.filterd (m0247527.ppops.net [127.0.0.1])
	by mx0a-00617f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697002oJ3309987
	for <linux-hardening@vger.kernel.org>; Tue, 6 Oct 2026 20:07:59 -0400
Received: from egc-exch2.psmicorp.com (webmail.psmicorp.com [38.142.134.66] (may be forged))
	by mx0a-00617f01.pphosted.com (PPS) with ESMTPS id 4h5b5e00pn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 06 Oct 2026 20:07:58 -0400 (EDT)
Received: from EGC-EXCH2.psmicorp.com (10.1.1.111) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 6 Oct
 2026 17:55:51 -0400
Received: from psmicorp.com (10.1.1.107) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.2507.61 via Frontend
 Transport; Tue, 6 Oct 2026 17:55:50 -0400
Reply-To: <greg@gospelmusicuniversity.com>
From: Evans Thomas <_us@psmicorp.com>
To: <linux-hardening@vger.kernel.org>
Subject: fund transfer opportunity,Reply..
Date: Tue, 6 Oct 2026 23:55:47 +0200
Message-ID: <20261006235547.4FBFD0C2343EBB75@psmicorp.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: GWzEJrs7INFuDBpu98bP5EETH-_48HUk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfXzDfoHDFgM3LC
 X6uaul3CkJ76nLKhKcmWtJPm8qRAn8O9oRVmW6u1nrHGRmXNitBzCwLE8YyjzrI5SLBLE6p53am
 LewuV4Wz1DM4dwbQ1IhgT1oDxOoj8P8I9ad4YIa2abbdnU7suEzuUddR+IW3JEtvSEyO/V+raPm
 JB1gOjSj2xqED58neT4QNiyDn6Hq3Mdt3mSprgq6akmKeswERaj/6pl1VCKZ0Rf3C1hIaNoWG8l
 GybcE05OjPlTjM9cNGdCpHwWD4FRefumFV6J4xhXsELY+anpUeJaBM9yttScH8FNFS9A4xbIv5Z
 CTUNnJhcF9CFABZMrhfyVC9RxMH3P2j+4xWLoRnO+pyTGLMBOvlTWy2zV7iVo/i6yNt3Wu+06on
 iSrpiHCEQHSOMNcSSxHh8YzsEAolsq8rUQ2Xb1O07JA2vacVmZIiyoJ5LfEf8AA/FC5jvSte1n4
 bnX0xM4Plq6lvxYskeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX/uqY+gZpTmLF
 2ljdgP3xDygp0p8WTNGmRRGs+g1FUSGZF71dm53VnWbkqXnz9D7PUNOGJbhSCiqxqtrT6cJEb5L
 BUnWGTfF1HiJu54RNnW7mRKL/GsvG6WGfY4THw1UB8d7zHBZVREq
X-Authority-Analysis: v=2.4 cv=GvTXaU1C c=1 sm=1 tr=0 ts=6ac58d5e cx=c_pps
 a=sNj4pI0fii9qGHoVqNzRVg==:117 a=sNj4pI0fii9qGHoVqNzRVg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ZHGAjPH774soz-f4Le74:22
 a=GfZueQGhKz3ujf-POmTq:22 a=tclcd6dtLQvEqt9_mmAA:9
X-Proofpoint-ORIG-GUID: GWzEJrs7INFuDBpu98bP5EETH-_48HUk
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070000

