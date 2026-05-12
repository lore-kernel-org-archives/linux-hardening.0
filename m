Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDE3B1022
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602498; cv=none; b=RvUhNE/1D5wpJ09JMsYPbGkJSqvfaw1iPpQF3E1Yvim8hIxQI6hWjD9X0DHyQMAaAW7N1ZNSGWRqo0IKmjSqnenrhO/YPDdwBTwAepBTuYXdWzojdPLL3aKZmAWfWSLRGOXV4+lkUJGsVXjlLJ2LpAQL+MVRU9AcKGAPq/9W2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602498; c=relaxed/simple;
	bh=nOcHWv6QRS+ZGxGDWNYh2zAFerYWBeSjlTs2oBQGdw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EW5CYIv5rvob0sHSyKga/Hlrun8b77to9mnfoGxP6m+WKrVsma6TWY6Hk7VSsIB5YOaXUTcSYM6yMgvn2ENfYRgDla3VjIkgPpPfVCtNUfekEg75wqAUyvj0vppvU+vdLSxy3+x3GkPdsWIUP87lAqZZUDMdWPVBnoepgBKjUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTuxMx0d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iMomlbs+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTuxMx0d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMomlbs+"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CAklV4740774
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 16:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dearZrYdES8kldFVf7isD4SpduWQxApzD6N2MFZnRNE=; b=GTuxMx0dzEzVi0oi
	355AdHSL1hNFcMHDkJ9/94Dt+X6CoZ8K0GBaioGeYh00BXK0GZ0LVzsK7qzbbn6d
	jHEIT+ImCe2/kVS5UYAJ35/OVcoJIjqQtxnMHV/7Nx+B5upJXGAEwRpyo4eKd1pY
	uMAJtU/9tv9H6ZAlNTn+Jv0JqU9jzyraw31Nv9BL74RLL5zu+pCQBi4cpiOVYx0Q
	/FWVCoX0jou9+RBNVbwgOimibZDgrG5kWCgSISvkza8uZgsck4XmKtcII6TZCv+M
	sTe/KhPLfhyzxCm6bSYIAHmtpOU+Mk+wHYwMu5AuJDvNjc/XXBT5NlOBFFGHoRoK
	bxS2pA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhsc2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 16:14:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f2d983d109so7645234eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778602494; x=1779207294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dearZrYdES8kldFVf7isD4SpduWQxApzD6N2MFZnRNE=;
        b=iMomlbs+kP7ozvha7FxN5itFbr3x9rQ/2Xnlz9Im1qLLg/VY5Pl0NRS3GqH2bdBIvs
         81QOXD/lmngpfk3vJ6mcSV+JHCAYH0FWcj6nYu11mpHxLnBKbKLnhWpMeHJ5HJvtm8MO
         GW+IQTuaEtQkm5TDIzw7dF6GOHouJUaVpy2bugLZa0JNM3l9hkecIsAUMSG6bXSTN2w7
         7Yhxmq9n2h0lEf7WMtyd+rn55epHpPYCrMIEIvZ8aQoypDULZUM80MmK4M/gQese1Hw9
         DyXZRhXkucztyCjLN2uEuZMcgN0MgW1BqaVea/a6jitYmS7l1d4Vxfdxp1nCCG3k3QkU
         icGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778602494; x=1779207294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dearZrYdES8kldFVf7isD4SpduWQxApzD6N2MFZnRNE=;
        b=Bkk24ziYG7dy0RlHo/K95vkTLythFeXRyyPAC/vInXC6C/zf/WxkcO9661uVkfV+XV
         BbQysijxlMzu4k0wXV2VsgKVF8NK+XOWckNwDmSr92jynGvRmnJ4j1dGY9fGt5StjGV4
         tIfWUME2oQwfO+eHfpYTppFJ5+zq7eTiQV7g6ryh9qabeEuYuAyhfjXOIGu7PCIya2Gb
         AD+oQvDpiOVSP9KA1qA8lkrY5yzRvuMN32dPLQXJvRBsYeN8WFYonSIEbbdUSH8gpV85
         lpXu1kuPz9ZQKX7RiADsLb4Zjd8qSGLcl8t5toiUHs3wJI85SnPervrdu+K3SgUNbvXZ
         31xA==
X-Forwarded-Encrypted: i=1; AFNElJ9RLC3OzqtmVCx+qy12QRk86/ZKjeyFu8mHynUWXgfYzvTyn6owUtI9si2SexzB3VUCo2QPnklddYGIyJ9mYJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSXosdSP5JXIyYmfDybqejtDephU0J/kp7uWuZ1nQu1m6c3xa
	kaTTzYkxIFXYAsUt1daX1cx1DPIPtgdw2XFP2Cj22viObwmUE/+32SwuMrh45ku1ewR2CRe5XuS
	q1aWOwLveSm7i2gxOdRuUwTGi/0TsVRVT/9sjzbcR1m62gzYQwu32KJiJvcjpID1PvWdJsMY=
X-Gm-Gg: Acq92OEBGni+OH6rTQjmyEODIRl4ztrbDcDnW5M67S+2UdUj4IQoJY+EjPoMiviy2jG
	Bzjz48ymT6555BheSK6nHYI18NvjddaCAJeitvag5Fvlxu1QzCz1UVEBomm9MT0ScN2pxGUQkMn
	smiEEt1Wu59PogpeSSdnRr+QnJbFJrAk6Tp5dCTe13URZ6jPUutYDyqeqrOOL9azlNQmqaOyvjD
	YOthjYQvoJQlDYB+48FaXs7YcypM7F9uMPwOyoQM6hALpxdt74woxnh8BaBqywiGeD3qKWQWmoM
	UHYR5oODFwu5zackheBt/Wv8CNvyQGMI4ZKEACVnmSEOFjUzwbUxxA0eNZaxoL2DFBEJcHLU452
	jd2p8swmkZx6zFVO4jf2mWvEaFM6Bt4k6iPMR1E5CKUFHJynyNNbEtSauu7+lfOfMYP88QscJxb
	w=
X-Received: by 2002:a05:7300:478e:b0:2dd:405f:89b3 with SMTP id 5a478bee46e88-2f858348089mr11196200eec.0.1778602494242;
        Tue, 12 May 2026 09:14:54 -0700 (PDT)
X-Received: by 2002:a05:7300:478e:b0:2dd:405f:89b3 with SMTP id 5a478bee46e88-2f858348089mr11196174eec.0.1778602493662;
        Tue, 12 May 2026 09:14:53 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm23156644eec.6.2026.05.12.09.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 09:14:53 -0700 (PDT)
Message-ID: <f37a917a-6bbe-4321-be11-2aa59c15f85c@oss.qualcomm.com>
Date: Tue, 12 May 2026 10:14:52 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
To: Rosen Penev <rosenp@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM CLOUD AI (QAIC) DRIVER"
 <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260401220643.12802-1-rosenp@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260401220643.12802-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2OCBTYWx0ZWRfXx+F2zz2fCP6H
 2uezFih04F+D09jZk0GNQv1hzd9ikiQcJfjPIlyaoxre+WVa22L4X0d4ljmg9r5/gWS2lhZwW5s
 TBlKLVv0+SZJGmUc0LBmqNE8s/VMUXMTqxXF10V1bmC1ZgpiUFPy4fyJHWo9ryRfxzTkhE2II/H
 Wo5ByaZe07SQfqlEBKh4xVSTWiMb8Tf35W40H592Z6bj1M1EXyWLpGraoYvOKb7T5wighzrSMkj
 7xgxzzTiydlcul29v8nVgBkWS/0GEMPZ8jGBxm7Rk+pnto2EamSE7OpjTvNXbqutm4iYoZLqh/I
 +O+Bqo3wCME07tmPlhKdaQVfkx/qU917rubpc0sGboU/Zfswhhjx6O+CGmViy9A2XtuMnlpg7fW
 /l8L31WLYXmYWU5Tpmc6hQa5GzHcgzbQnN1I5SHwBfLNzIUfsc/irbwxQ+jB8kPt0kvl+v/chEz
 q0t923lQ5tt1lQDw/ZA==
X-Proofpoint-GUID: 4Lu1ph5t-54aQvYStN5LyfbBGhkxtsdN
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a0351ff cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1lcS69py3Ix-9TsBHUMA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 4Lu1ph5t-54aQvYStN5LyfbBGhkxtsdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120168

On 4/1/2026 4:06 PM, Rosen Penev wrote:
> Consolidate the two-element allocation into a single allocation using a
> flexible array member. This reduces memory fragmentation and simplifies
> the error path by eliminating the need to check for allocation failure
> between the two allocations.
> 
> Add __counted_by for runtime bounds checking.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
