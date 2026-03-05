Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164F37C91A
	for <linux-hardening@vger.kernel.org>; Thu,  5 Mar 2026 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705201; cv=none; b=KQXJVX8rrsFkCSmI4YaBcdHCRs/ZIfRfxX0wxqUiMivPwCls8ITer8/00h79vw5DKjHdWmwplGBL9fvqA9MQxbWmhLKEID2wpP+n3jrbIjkK891MZ1eksI/Rbw6O0r5dl3vlhpP9ft3PUfLKXXVkJXdD3IhigHuZwRX06na9DlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705201; c=relaxed/simple;
	bh=geYlLSGbi2ubWNM3icP3wHbx1TruJTxDtOkQ1XJIM6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpjHiMns577vVzrSsl7f2ofcF/l8KhQBa9vanSyo4E6yxr2ryfMhdN7NmSunT52qTHLt0q5pTVpJlcY3nPydaJX1L8eA6mB07RhngQoXDkTc34kNQ4JN95KauyrnUbbfoumwcZ104Wgil8I8CFGB9KcSi0TqdwAl/2rvaEjxy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jbqng5yY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SPMVF197; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jbqng5yY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SPMVF197"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6258hE0Q629141
	for <linux-hardening@vger.kernel.org>; Thu, 5 Mar 2026 10:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aH+1VH/Xv9GKxmfwG+hdhM3wTHJXfgKYGbIbiNxfOq8=; b=Jbqng5yYpTNQh+St
	8VmZoS+s5K7E6DPwB7WPpSs3t857DR7g3RR2nlF+OP3G59WNF0CjYwEAFR2OelIv
	bT9oyImelULQ4TkFGVF0Lvlotkg14b4AYrocYDdzIZs+E558njcBBlHexXS294Uf
	3jXRAEp9bPmJq8jkd6k7ZdPvvOyhFSu2wX937Qgo/yPXvc22F1XylocKttf4iJu6
	B0ZCf1OZ6maJtGhJ++cp/gSP+fAPrCWZImH11H9M41wVj2Wgy1BohOc2Fj4CFt12
	i2W+TynPV+LNp761eUqFc904EvrY1iQ5p/no7z4i689Ts91hVC+Mp8t0DVz1iDaz
	jgDL7w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0m2v7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 10:06:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb45a6b860so452848385a.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 02:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772705196; x=1773309996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aH+1VH/Xv9GKxmfwG+hdhM3wTHJXfgKYGbIbiNxfOq8=;
        b=SPMVF197MEH9d+mB85CljJxq+afLfPFkG5CAWrk80ZwosW1rkXeMaKUw70cdcYEcrV
         3tn16a5SPRGpowUroSKYAyohnefdstgVcwJebpW6yzjgfGxtZz5r6VQ+j90xSkU1vmLB
         vijy3UKRw1/M9Ohe78/tY8fuN321HBxyMCIOIgT74rWaLqp8vWUNv9bBTJLML3st6NxT
         xFwe6RL2mz98Csckr4bwEv5bBKNFKZoQOvhw1Jg1araK559E9vBAMPgkVexaFCt4KnyR
         qFY0xTm5aysQT5jXClsVw5Ij1gMQl0P13hZAO4cNlPAOTPGyNKeJd5IjSwicNPUvqA2y
         ajUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705196; x=1773309996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aH+1VH/Xv9GKxmfwG+hdhM3wTHJXfgKYGbIbiNxfOq8=;
        b=pLAziRrXrxj+W91gIqr31EDUDQdkHZfgmnvciMX9LUPH88Zolbd0QlAbzim9acvnHk
         5aRAZhktm/5n3m4bgrcmKUc6FxjYeK6RWWEyRFDjj856TN3GM26KKO7kht7phWdHjmKN
         YlVsSik/mbkX8OPwAJddKJzHJfNPKyDgIp/VS0rNUxdeofCvT6w0jmLIzcJbSwSkjLPb
         0dR+h79jeB7JlrBG4Ut24wkmrp06Uzcdlph/aVQzbP+t3R3Qj/RB8/1ooSDtv5tcKNxW
         jVIvUsQCcv9ez9KGQDpWVem2H4llYgen1BiyITncyn2bxQelnXfR+a/oSPSl/3sSLIn9
         602w==
X-Forwarded-Encrypted: i=1; AJvYcCU4xcxbplaQNtZ1J21aYlJbfyOaJaa4xqQiu+UN1sZu4GUF2i6mT0K4xdzy2Hy4NqbALul1XUDad9f6DjDNe9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGiKW30k2izZl/BChS6/zdrbZXXiltH+//bsR1UfHwniKbN1I
	XgDjkeKyVkq1sAOCWMEyB2XlxnIcoix4NbXCX+1EnWzEz3AYxj+tBBOzJkDrFo7wtbLiytLS5ml
	c1j2QCdabqBGjkTQi0f22nuMG95i8Pok6VbtQs1y51gK4KeC+6sC5N92yfk/bLHIKoLPvlnE=
X-Gm-Gg: ATEYQzwmzPHi2mlLM/WxsHbIMSK+k7quFc8ndbHKufdIYId3Xvy1YK7eoefNbmlwCmK
	BPk19QSaxX/m7XFCh7sdD9Pv9D9Bxh6bbrvqyI0g3O/3DRawhbACOQ9CL43uKrI6NYnk5lEUbbk
	LSvjvN0W3JnCpnAYFPejY4j/tQzhc07hjwQTRJ3kKcnqG+m9/WoKiIsTn1JGI/q5iox5csM3kxv
	gEHfy9Cr7FcC3+/xQ4UAriujXMP8dHXqv0jPsHdd8I1SG4/tNcubtPQf7IvnaL5cVl8Qm2hfgDE
	25P8FWM/f4K8cZa3xXZcjXn3weDlErQ979vzmHnBvfxJvae1NONpdTKYxH11b3gmtH25I96EFmE
	XFbshJIGU+JmmsvkWy0PSgZOQamj+LC7qv6M2xTfGWu2ATw1NWz0DHjWlMOfWIQkribkkY7PghY
	yhNHE=
X-Received: by 2002:a05:620a:29ca:b0:8c7:17af:7ae with SMTP id af79cd13be357-8cd5afb6a0cmr454827885a.7.1772705196041;
        Thu, 05 Mar 2026 02:06:36 -0800 (PST)
X-Received: by 2002:a05:620a:29ca:b0:8c7:17af:7ae with SMTP id af79cd13be357-8cd5afb6a0cmr454825285a.7.1772705195580;
        Thu, 05 Mar 2026 02:06:35 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac66feesm878548566b.21.2026.03.05.02.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 02:06:35 -0800 (PST)
Message-ID: <8d7a25e8-3af6-4adf-bcec-394895519bea@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 11:06:31 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qualcomm: usb-hs-28nm: use flex array
To: Rosen Penev <rosenp@gmail.com>, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260304230636.27808-1-rosenp@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260304230636.27808-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e6wLiKp/ c=1 sm=1 tr=0 ts=69a955ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=fNKL0_Y_EPOiR77nuckA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: zYx65YTJArTCUW1zjCYgAVY-lmxb4Kkf
X-Proofpoint-GUID: zYx65YTJArTCUW1zjCYgAVY-lmxb4Kkf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA4MSBTYWx0ZWRfX8aPCKouiUQAH
 YIKztUjKxfbGx3nCuBZBIHxy6Fn7Sab4RIgFtKOsr8lpVSHMYX2lpXRRRLwIoVt32HpLIxfcv8X
 /iHhnJJx5EitnlTcRYsmv52oHTrSPd+05biDFBhECMvjqae99i7r3++fqOS6vqsQY0rrHzR/V24
 BAz5jI7aA1I2Q44P0Z0xJPlj9QtsGFeMz1Oui4Di/lFitCwIu91QkovWMjzibnEF/OwP5K+A+5h
 s3rqvvsuKYrcJ4AdErOB35kXS4QpzhTqo66LNS7RLidAcOLdVEifHd/BEWKlHeLvrZBxl5aip+R
 yn7Ps2Qxnz0DM4ybqwcElwI3zaOoJHVJoK7RMbhw9cqL/Bnyf0Rpew+R84/6VY32AtjVQ6NvZNG
 BluY/3xlgCevpFoofdYDX2kzSRDs0Zk5BLll+9cezUKAANERoxfF1izr5Jm3dQlcp+yhPR5uSz1
 zTN+W2NlRWmdOScxuUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050081

On 3/5/26 12:06 AM, Rosen Penev wrote:
> Allows simplifying allocation to a single kzalloc call.
> 
> Also allows using __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

I don't see how this is an improvement - __counted_by() is useful for
cases where we don't know how many entries there are, but in this
case it's fully deterministic (as priv->num_clks is a compile-time
constant)

Konrad
