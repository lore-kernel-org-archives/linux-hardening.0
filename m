Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC92DF12F
	for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097409; cv=none; b=ta5MLVO8ge7rZ8FD33HGiW+UQidrPOlUGUzjDRxb2oEHRzUt/X7wkfsPPDOBjKNKVvQupFAC8ESbuNl4huwQQAVIsE4HjSm/KAmxBr5aPqBmJjGMmb197gmF5FH5szJWOJWvyQEfS9m292BVLQHgOnNqYsq5ZlHXPkTX0sjsGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097409; c=relaxed/simple;
	bh=uVK0Xv59JS4HDRNv+cPyPShGPwZXklo3HF/N1W3tfbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGeT1oqXGtBaQahd2if8qzNb8sC9uNLi6Pu/zkLPAexQatjB/GL95t6vjQVDIuUrAl600T7ztonQZDtaqqiJ+RT7/crCgstWnOp++wq1bJjUUVL66nDgguPIoYiVWaLy/iSGydKQOBSQ8CKc3qC6S6/uCT/ErUVNODiImueiBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fH43SR4Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WLS1HsbY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fH43SR4Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WLS1HsbY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DDm6vs1496998
	for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 16:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sguj50zvkqWIPPgGiJFdHRqt
	8hG3/As6/8RC0jZYNNY=; b=fH43SR4ZwOI1vQtcxZfpOJCPOa0cnY7YyCDHlEqk
	z0StHl53D3W/HbRH6rThMluzHVXVw7ODOsRtI6a0L7fxv2fY5+1apQySs4dCXCzr
	A0jVHH3BtaF/g7yy/wwW2o1W/Py14E6nu8SSzT8qUILDgmS5t7xBQf7IIMAWPkHA
	IegKPVMbFuWfRh6GB9NTxTtpTL+lhrBoPyHq4PlN/K21uF9XlNI0TnyJMtMWNIgE
	K453HmjUtwTMk4V5s8XOw4dDpRzUuQh9stFmZeMntaVU51jgv9ddaP1gq7JnZ4TZ
	AqXW7ioqwpJ+1kGG7HVVfDJmfdyWbndvBOnnjHfnH8D2sQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh1pk8k51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 16:23:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354490889b6so6541592a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776097407; x=1776702207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sguj50zvkqWIPPgGiJFdHRqt8hG3/As6/8RC0jZYNNY=;
        b=WLS1HsbY3kqch/mqy8YcfowbsgoyUr96PbQuehLHA2Mm4U4biwyuSLQT6MXIn7mztX
         8DlWegpikG8u5an3EmCGDEZ8XCXV6R/UO6gcwN2hMqG5nTSNLAzIZwSVwq5CaHMn5s9X
         lXa7wScdhDw7PG4aVA3dAVksdc4qkhOcTrU2Yy2dtqw5zUxV00uBqQye+aT8BBQPjyzQ
         yvtAGe8y8kr+JmylvRdmq9FDk13UdG17ASHtHMGx+i2sfQunovLrYScVpM1j6shiWO3o
         3dZ0WokYjPzZnccATO/NLguOjYbJYalWe00d0eSrG800cgxe9wigIOx25eHfEtK1rSoz
         7E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776097407; x=1776702207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sguj50zvkqWIPPgGiJFdHRqt8hG3/As6/8RC0jZYNNY=;
        b=ipnTC9CqKILnx9A7dmSsvBqyJJoqUJwSZel9Tt5SY7VIa9G9S/3aH5i3FvsFOw//FS
         MiCoR5nLatkuKfbvKVoT+pTZ0GMe+IwC520o6SDGvlHsYfjrD+dkOXmFaXbX2ueYA8bT
         pzX4XEyeOnYQ1hmkHWpPHf/DrQUN3171WdFPIu69I9G9eXI+5Zn7ZfuXOmMUk8W54EyI
         5TA6P/+Y2CpXVNjv9QeoxyJCS0LWzKc5vTjPWgO7T+eYB3HDabY2qcFI9ojrMnkzR6pt
         PFhamq7VBrTHv2aAYbaW0p45qLzsKzySV0u7slOiaqNixYFBXeYK6hCIItE8n32fZdzq
         QJug==
X-Forwarded-Encrypted: i=1; AFNElJ8C4I2G8Q9Ty8tXDP1TBbqKnLiM1TeTGT0tXBVOs73bw+V8XUhi0gejLEzBQa1Bnr5dS/2p1izPUN/Yc40lHSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrWNXb4AwQc70LgW/iznFv8EWmOJvyPZoq+JNS3Vcq1p9lxFBf
	dJ70RBVRIrX6byFKcibx5hnYmIiHCIrPv0kO5DVPSfjK/NIGCYAEAbpOsAu9kAcuIgaVNzpFTVU
	okaY7ZyZpOxM0MYkN+yHc3oGUny+2o0qWUXGBFRtW/XpA+6ifDO+vZ9wC7uFYfMwcyeklCHQ=
X-Gm-Gg: AeBDietWKKzIRdIR0ku6477q5uE90fx0hNKsCByizmEowNt5tI/SOkw8h/aq357rEtl
	Hb+N7mb5j/lGJUaMBHEwDE7EppGl9OQlNATZjUNHbrl94/THmop5nRjzuaJ6KGYaowFcA6zKKML
	Yg//hhsWeWUMnxB3gp6/Gi4UTDeLpyj891quC+I7HAcoGQNnk+w1doliMfprArxgEPZn3IeIaDZ
	SiA5p3XYF1WOoFZ4PolnG6NEG1ouuatMv+N5jaIPzl3FRYRAecjCtSi3vzGwgn33YKSw4KR88is
	ZFHeYjf2Zrp+4u8Z5Es9E5TYNFpw2krjl+vLeXiFZuG9Z05bXEqt4OwA2MAZlWARq+MGgo3/Xbh
	Ec5/QrAduaaNWmbIBnyubjsfGDgBZTKW/2rvtEG9Q0PeBbC7o
X-Received: by 2002:a05:6a20:394d:b0:39b:f12e:d51 with SMTP id adf61e73a8af0-39fe40c77f8mr16132376637.57.1776097406645;
        Mon, 13 Apr 2026 09:23:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:394d:b0:39b:f12e:d51 with SMTP id adf61e73a8af0-39fe40c77f8mr16132337637.57.1776097406067;
        Mon, 13 Apr 2026 09:23:26 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a36898sm9831729a12.31.2026.04.13.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:23:25 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:53:18 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] soc: qcom: llcc-qcom: Capitalize LLCC/EDAC in
 comments and diagnostics
Message-ID: <20260413162318.utqodq54calhoast@hu-mojha-hyd.qualcomm.com>
References: <20260407-external_llcc_changes2set-v2-0-b5017ce2020b@oss.qualcomm.com>
 <20260407-external_llcc_changes2set-v2-3-b5017ce2020b@oss.qualcomm.com>
 <20260413152528.muemkbfuow2qg3ta@hu-mojha-hyd.qualcomm.com>
 <516270e3-1d59-403c-ad01-7153147c9e30@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516270e3-1d59-403c-ad01-7153147c9e30@kernel.org>
X-Proofpoint-ORIG-GUID: C49uJcJIKdfqGDbo_pvrplB8QYWeIuzq
X-Proofpoint-GUID: C49uJcJIKdfqGDbo_pvrplB8QYWeIuzq
X-Authority-Analysis: v=2.4 cv=BoitB4X5 c=1 sm=1 tr=0 ts=69dd187f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=A92sdfvMMGvHn_BerJIA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2MCBTYWx0ZWRfXzyQ1kUzJodZX
 zqAG36LmnBzwWHsqLmZQhjdH43GDM8B6FD+M5jl0qGw6+T9vBDzIvodIEMKdilg/LeIEzYYiTai
 /ZzFUZmI3rjhV6sfIRI0ddKajyyU/159whx1YLNGYQE2WRVA65Xu+Xjw+R9ggFo033nf6s1W/x0
 LhVt3mKWr+jkRkAtucO4cnvjVda6l+NroAyll4uGkOb2QlJJ6eNP/SnwO+CmpJTkI4PbltU9EMo
 cIQeB5JigUlXhU3el425xgYZntpl/CIEez7PaL0F3xMYeTj1FQRhzZEAmxnpLc9BjXZUcDle4Q5
 xbTL3qJBFEtaiRJKQn6Zc2ed/2UI16LG1vWySIbsVv5/K2tCCghKezg5XOaVQMxzQ9fbEoqAt+N
 aKN3xEQFL8aA5DWK4jzLYerRYcvRu5LKxLTS0OqeMFFaFzGT+GHNXw0xuXrgHmuKhnfIxSJr53x
 HHtfey6/xFh+gNGS+5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130160

On Mon, Apr 13, 2026 at 06:10:39PM +0200, Krzysztof Kozlowski wrote:
> On 13/04/2026 17:25, Mukesh Ojha wrote:
> > On Tue, Apr 07, 2026 at 02:51:49PM -0700, Francisco Munoz Ruiz wrote:
> >> Capitalize occurrences of the acronym "LLCC" and "EDAC" in comments
> >> and diagnostic text to improve consistency and readability.
> >>
> >> Signed-off-by: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
> >> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > 
> > This could have been sent alone..
> 
> No, not necessarily. It is close to churn, so multiple subsystems ask
> for doing this only with some other work. The process here was correct.

Thank you, otherwise, git blame is lost for no reason..

> 
> Best regards,
> Krzysztof

-- 
-Mukesh Ojha
