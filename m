Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E23B3BF0
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909107; cv=none; b=tS8QepfbdTNd/cC6crRZP5Tn0/xRJCifjXrMWJepf1YfuD2E5ku62kKM8xNisLOnDCAyhT7Ghy2+g7lMmcO8pieB/ffigpvcC4aZrOG5JjTQjYc7KufChgRU1KuUS9dQrcGXS8jldp9c3EJ7i4NHtq/ROYJ7zcUT55XYIbuKlsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909107; c=relaxed/simple;
	bh=HReFezNfdr/kMofJuLzTUUQ/PAkNAjV+vPvTQuotlNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ar6i6luRXBKT1JqDg2MCsObUFAOSy+LWq8Sws3kFsVGv8wcKtJoUNMbscRVvZO+6fQiKtZy/yBEb151yl8SsFszIobYKBq0blvM7epU8hvWl91gi1f6f4H8Hfbvx+GPuKWD4o9OSMX0yMWfvei2RTL2E6iFarnwToo5z5soQEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kECHpzv6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MQGNca1v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kECHpzv6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MQGNca1v"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OrYG2274533
	for <linux-hardening@vger.kernel.org>; Mon, 8 Jun 2026 08:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CGhJ5tiXrZbmeqn6GK4TnpDNV0Mk0psaT0hvDZqXFnE=; b=kECHpzv6/n2S2Qur
	KmYRefTWN/xNyvjLc0JPTgLvLZNlisewfjfu8uYyPey7ow+MCWEjVZ64ee78L4H7
	py28Q/+bM8yFX9RnlSPSFZ0FALfSlVX/0OMajg+HcmrRXEFZwdrkJuh5R+PZcGK+
	nGHLGySCDVRTxYZzUolCA7vHWC8J9STUXYf1qsJ+o2zVH0FHWW0Jd1OLns9ikpGi
	UejkmZXw6Zjx1bF5YQIZlSkDEfu4tQf3Q2/DWooZ8u3VTg3WjRMdqWuV/n1xaHvq
	kapYkxFFsweyYNCJDNeg9AuSnAJKwamAGgUQRrwpP/lOm3i6wf2Efs+W5YUpazA/
	k8zC5g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgxmxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 08:58:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915ccc2d4d2so34119585a.1
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780909104; x=1781513904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGhJ5tiXrZbmeqn6GK4TnpDNV0Mk0psaT0hvDZqXFnE=;
        b=MQGNca1vf/cSQj5RZNrh+u8ruLIXy44DvciyQvu0Y+BqrqRHOhbdEF8DdXBdA5cVR+
         CJTWDrpfx8T4LPYaBjycy2SOSbdmW9oyxC78C8BIaHxSnEVVGDY3pz0vDXAu19QGSxi/
         6gXQE5akgfJvzJvIuVNZUUASGfytQN3cq6dLQTlQntvJBgi4CoYXOwBYfU4obF2UqVbT
         FyVB+ITUR6U5U5+gVUMVz+oNptHS6NVEfTgsaawNdO9PDQczG/2Zqiaxq9NA+Y6kH9b2
         qy21IEOgiYm9TJWVp3eiHj0oBAR0s8asNQCoEORVQraaPVGHg/MG4+ZvrX++c3HLPPQL
         j7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909104; x=1781513904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGhJ5tiXrZbmeqn6GK4TnpDNV0Mk0psaT0hvDZqXFnE=;
        b=aFJF3rPd+j21NkpheLzI+uUcFMCEG6X8PsZJ1MfSGNfQsGybPoSAkUt5nGvcqqBiu8
         hV5UAX8Fe8+javeJzkot5CtZCl3sFTWeul4mPdAhqF7yZvzpUdZQGUXpi4GlWczn8uzb
         +Tk99jtHb6vIQRjowTe2je1vH4DS5eD6Sbsqv681qqWC3xdKpm6C6RWxa+7SS+QggDLg
         ZGNWxY4sbtU2u1+FGAcd7Y59q4eb5NyvPQEuGmaXtIE87C+yHj1rKizr0EDkzDa0gl16
         T+ZiyYI1sVjBU6lnGvE933hOgx0IcP1sp8La19Xsvf2gC0/pLWlDvbovWOKowV4Yjosq
         pYLg==
X-Forwarded-Encrypted: i=1; AFNElJ+MA7nsoXj8faC+m8WNnpKHc6TCfxsYf2neR9+5LlqnR2E+QnG/SIGX2p7YEkyU2okUuN/cYurNewzddKVqToM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yBAOCceitc6+2cpQXSHp1ZVnZdb0p8Dmf0raL752WCohZtsJ
	VTut7325RYkNWQ5mkb8ul5HZ6PID8z+2XJwwa0gFjH0e+6IVmNmcz0N/ulWHpKX0JN9DQYNgMkm
	1TPcKMqXZ1A+/nEy/CoDnmORMVLuY/sPGYAI/wCayA75pAiz5m45b96nomBblQB91wKXoglA=
X-Gm-Gg: Acq92OGheKZujTjtph3yM6cwO8gDs7D5vXrsBRsHMEYatXNdABUAqjWotodTcJ2EI6L
	lWXJUHhMu+iLxjpbeV8KG0xHFMpBU2SwJErLw0MpQ5aD6/4I68avgyO+cykYOhbLuQvogXES81y
	PwsWfNCXbafpOU6s8rbbJoBHMzD9o9cMPlTTOz819wWowoZl1UxA8Z8+8KbbqStNwVye3SKauyR
	x5vfT+IfLneucEN0RXxVdNnwP82eM9izR4g/E9Dgtdi84iInp4tp+12LKMW5x9igOahMEZqpdWR
	8V6Ersr43BIiR6e+TO5RSrSShnRhMVqx0fI/pdxfRbGa0tfiiVS6ttAIuRxYLGBHC3gFREGKYNr
	IjcmrfObNR+/q5B3euPIpWttPRH12gyi3q+Trgq144Edbz4g0WCJ6Mf+q
X-Received: by 2002:a05:620a:40ca:b0:915:83fa:b3d9 with SMTP id af79cd13be357-915a9c21c3emr1321678985a.1.1780909104507;
        Mon, 08 Jun 2026 01:58:24 -0700 (PDT)
X-Received: by 2002:a05:620a:40ca:b0:915:83fa:b3d9 with SMTP id af79cd13be357-915a9c21c3emr1321677985a.1.1780909103986;
        Mon, 08 Jun 2026 01:58:23 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf2f2da4447sm556288366b.10.2026.06.08.01.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 01:58:23 -0700 (PDT)
Message-ID: <9117ce31-2cc9-4f52-b223-fe0dacddcc65@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:58:21 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: simplify allocation
To: Rosen Penev <rosenp@gmail.com>, linux-pm@vger.kernel.org
Cc: Georgi Djakov <djakov@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
 <linux-hardening@vger.kernel.org>
References: <20260608050429.5990-1-rosenp@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608050429.5990-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a268431 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=7l3-gkCRI4JLb9_0IUsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: TxMc8ATUROqs76RIrYjqaeGcmwTDGqZu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4MyBTYWx0ZWRfX5FRJ0p7OOOOZ
 QVM5+086vDkhPMYA54lfRdkTebfBgQHcZz1YftZd8H9L29XPxoa6QANUUizfeVgreUEv6ffd0XR
 rdYR0PFl6f0OsXySK5J6e6CKXA4LkXWam7r1a2jN+o0KgeL/CjuYFEaB5LrSaQEce+KovpbpUqX
 0SMHS+YZLCY2bknOe8J71Aoj0/8gw1ffe6qAo0iO7ckXytxAHRTCxYstch960BXNRfRPCWM2yLa
 ExPisshr8whW+veAQjALrnPM9FmvrDsSrEOF9fVG1jOj4hLKnYavFh8XdIElyCp4VCKgYinkKGZ
 SA5fisssNnd1byqDCSSnyLfE8c47eU6cEpAbjxc267wFZ17md+zVazzX9/r2pQisn+w9Jco61M3
 CI3xIsNpGy8taCVqzX4pnKjYp1XcJENxO/UIAe4BnO6QV7Oq80pZisTssoElG+bh9AeRhsxbkCd
 KN95z0Y0NXQB0C4iVFw==
X-Proofpoint-ORIG-GUID: TxMc8ATUROqs76RIrYjqaeGcmwTDGqZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080083

On 6/8/26 7:04 AM, Rosen Penev wrote:
> Use a flexible array member to reduce allocation by 1.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment after allocation before any array access,
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

[...]

> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 7d1cb2efa9ee..b08821c2ef74 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -64,9 +64,9 @@ struct qcom_icc_provider {
>  	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
>  	const struct rpm_clk_resource *bus_clk_desc;
>  	struct clk *bus_clk;
> -	struct clk_bulk_data *intf_clks;
>  	bool keep_alive;
>  	bool ignore_enxio;
> +	struct clk_bulk_data intf_clks[] __counted_by(num_intf_clks);

nit: it's easier to visually track if these are kept together. I think
you may also need to update the kerneldoc as the order changes

Konrad
