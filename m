Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673893CBE8B
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584653; cv=none; b=b3yZcrnlmxxFBrTUsl+CrYLnUvgHTBKieGq8U+ukuKmrqO94KkLOSJkAY9HzpFz1iBLWO6hTMR3SazfcKDgsyHOUaOYs+nHpKg27QCdIkZxnddyCzUIRbBEreCmTM4xj9LJZSQ7HdfV4knNkLNc/XtLafg7+KPnoLkmii3rOeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584653; c=relaxed/simple;
	bh=BBaWX5+0ik9h6+P7M3E4waZsVzwKBPqfhLqiUzRw7Xw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jYfGeJyI/8Gc6WRqSCYVYviao2prvmaqg6ym6+tkyRvhctWQU9BYEOK/uwCF+uelZv2VJ+Rupp4LBxdA+XmppvgE6RDwZilmPmC1RNFqWivGhQZNyHoxYYfi6YvPRz1lEh2v+1kmDXpuwBxm7UHS6AAAfD8tK24kzrxO5Cy/AyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZrGxOElO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P0szqsM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZrGxOElO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P0szqsM7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UKIEjI1854179
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 21:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uytwK91gAW1pt7JYIMJ5S2V+aZdw+oowu1MjxGCXUnk=; b=ZrGxOElOtzl8/qMq
	TJ99FpwoeourjNBU0h3OhIJWbr04dQ/YH0SrIl+u3GfdBnU/gMcyY0iQe3J560I/
	ve3VDXlp4uROwkH2dN3rnXOc0cxDhWvHMviSLTv1fp1graYmoSh1y4a3YRuUcAV7
	1cLLfWKWxcTPh+16DpBsxL5z7PRkFMbN2/e9zDSUEDlP74ppMFszZLR7/r6UfdA4
	HtWjBrOlrfpQVx46u00IftzzqzxP2cwOJOfjhvb+kFn36Idh5ut53VcBmmer2ssz
	0qsfPzxb1oJyahEXQN/wDrNFJWeRPO1oXm1LfXs4UEnlH17wRsFCtnCrcXi9bonO
	FVqXng==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dve0g07mu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 21:30:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bda35eab74so1207908eec.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584651; x=1778189451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uytwK91gAW1pt7JYIMJ5S2V+aZdw+oowu1MjxGCXUnk=;
        b=P0szqsM73UeUCOms6NTutERO6B1vOFGffLqje+gDP0esAjIGOmaAt7fSv0at7GG3Ug
         i8vrKHov8hrgI6DPT8BQ1rccamGMTJtmoNlwGo065/5lrjNcQXpEYKmICRbl6rFQRZ1m
         EagbihKfrqwPpwJ/NcMWmfDB6sUAWkt7IIbgOt+cy/wU+Lfi4Hj5wYO23jAVxmnMMj5T
         wLqRZLNxFTiETCDMHv+YNb7FEQH/oOWaDTLaWiGg+yuOTBlSe4NeOhwZpO3AJIwY8O7I
         gO6HybIt3Nle+ipahB+3bXGVLLXHIiabLN1sL3rFd+NamQPuWLTG8bugy/PA4yBUAtBF
         d/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584651; x=1778189451;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uytwK91gAW1pt7JYIMJ5S2V+aZdw+oowu1MjxGCXUnk=;
        b=GTRKtEH59MK68Vm6nuNsvFkI0Ggm1853l9/pGME1klddq2+x/ZsaG6QknPU2dbwQH4
         P8BQdXZXDgqXlkjmyXWYPXVbUXyO/qcAyk3dD15CfxgsBc0wW05jBsoHjDA5BqJ2bv/j
         DeMhN6veCqrEnaVfnoT8cH7AO+xjFGBJ0BqQWYcHlkFfO2JDzB3aQz0Hh0Nzy/dpcJmv
         4x2R5nkK89w7oU0eA+CBY/jqVvV9gyWq2kYX/OJF1ehzJpo7n9SqrqzywUqEKl7Pez4h
         XrhazmVR3v6H8O9C/KPMozUVXas92LN+Fx6ArwZpL9e1F6ErbC8Von/7IzHa9QbXCMjg
         kJMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9M6KrUpibCsn6N7PPQCuY4QKi9ixA5JpxlzM+hYcFREIwu5FIlGAWGWIlA3giP+PgMu3ZR3JBjkouwygtfd7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqszG02RwPccdKzdteiKAeU5Ld3DWKjkTrITAjLZApwC+WbAE
	agPHxjxjEjJ82/gC5Hkj1UWJVAWnfyMoljrgRPDQMeSMUs9DaLj1Nge3Oy8Xl7FWn+ctLprYQOT
	T8R1W3jaJg19EGjfpxyVV/SwEdDj8wVlkH3+gZnhNi2KK2ZEGlcRu4NPnbibF9Z6HnxsNBR0=
X-Gm-Gg: AeBDieuFnRbuGit8p2pUOmfOvENDQRw9g7KX2dw2fhkUggQjJy2gMszmi0+jlPo77c0
	lzi4W/MVnoInIqsWJv06+p+qC3g6HoF6eh7r5VQcZgUjkZd4AMAuVkdVwn0k2hJarE+SLIOPBkG
	R1NGUSaPlhTodaXbsJmFW7zDHvy0U7X6d0bfmagJLg9agSNjI4hJA3zMLmrNsCxrAW+G9J12+oU
	JIgnqoJvzg/x7ekuOSu3j35U+JFwyc1ki+7mKBwg4KN9O3ooiGrP27vdsq6xhaUx/xq+xyrllwA
	FEGwLxWZ0iYPHCnxkNrjNbDrC/IpIrKPsO7+rAkgyzqizh0RYGlVFqrhWqEjwwBu0AdCcOfTc1J
	RkSqWbK0yhMwydtEL8+fP2jJuabuXgPok093sskB6HXdE9wqAKuw9aLj8qGxk1fMi1T3NSuiISM
	Mf8rTtiRlLnEQ=
X-Received: by 2002:a05:7301:1902:b0:2c9:ee15:a0ee with SMTP id 5a478bee46e88-2ed4e7f58e8mr1968589eec.12.1777584650791;
        Thu, 30 Apr 2026 14:30:50 -0700 (PDT)
X-Received: by 2002:a05:7301:1902:b0:2c9:ee15:a0ee with SMTP id 5a478bee46e88-2ed4e7f58e8mr1968563eec.12.1777584650206;
        Thu, 30 Apr 2026 14:30:50 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:49 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20260421213544.6238-1-rosenp@gmail.com>
References: <20260421213544.6238-1-rosenp@gmail.com>
Subject: Re: [PATCHv2 ath-next] wifi: ath12k: use kzalloc_flex
Message-Id: <177758464918.1848985.900364470995895282.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:49 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69f3ca0b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: aOggn1xkH8g3iAy_XOVGcJ7DSFOAuC_O
X-Proofpoint-ORIG-GUID: aOggn1xkH8g3iAy_XOVGcJ7DSFOAuC_O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX4JA7SIg6e6MY
 Ar7933wK6m/afkTlQCDeE8InJlDnipTMLo/FG0YI+vqc3iWOZPcTSBiMTFa92dXE9KPMMBuXcbS
 aNUcsvfa/aEKR1mZRhNyYUPLva9e8+YR6dJJqTuAGhN+2I1EElCf/637E5u+M6xYDQ+llg1aFPz
 YxaHrq1r+c0IrNKH7tUy5CTrgmSaJZH/8WW47ybbwvEZlBrLbG1T+yZ6GCgB4T9SDEUdoF4s1z8
 MeRjjye1eK5+I1LCLLveGa/IZAWVgUPTXKIWGxQqrsY2uPCVfoRZftsPbPuC+CRxzAils9vEDVB
 RTFpUzw9KfY5/o9e6afEMCY2TaLpQSBMctcZj5HlnIRC3bPPNgDBIRrdfbRVmVpRD7kqqz/O/KW
 GRLBGf9Djruz95I3M3swN7OxMFsCA/FGkeuBKhcfhN3AJCFgbhyf9jElaaqz3bdnaJh2DoqlFm8
 NZqq8g+xJEoDIuSKh6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222


On Tue, 21 Apr 2026 14:35:44 -0700, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: use kzalloc_flex
      commit: d88c3a5117c58e1d93c20a7c723a6ad23136a430

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

