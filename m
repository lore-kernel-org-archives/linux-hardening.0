Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F003C9EFB
	for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093940; cv=none; b=hFA0K3ZxeuniS8+jQjfoOiyr6s45y3E2e8q2kNyVdCYES+LrH31ofOOFQveMqnIuBAH7quTlGlsUihQRodFgyQW0HLGw+BFVxlsRQkIEbfn3Sh4ESQsXada/pvUoS7cFO3/bAWBSwdYUGoBx7f8tS2kh8ybdLhhss8+wYYLI6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093940; c=relaxed/simple;
	bh=GYGj0slXz7KuN30SwHL2g1WodTxjyroqUBFhNeDtSwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppv7qckKAtYgyDHfkQi09igFBXK7u4hJzNUXVxRyTkcT09ocdufxG5RFUVZ6daTsjZgrKxkiAInyTnf+Gs0w01fMQ/g19Mx39I7zN3wsCTZqESbYOCOcAFJhgYoex+MhFpw6i/rlWmbljQEXi4Nr9wyiocKOfKun7Kl2D69gyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+mOuETM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F6OfzxFQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+mOuETM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F6OfzxFQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DDm8Y81497251
	for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 15:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=W7S+vUEanThPK3tKQ/ENkOAh
	TzWh25gKbMRUR+Sltyg=; b=O+mOuETMsOD1Hdkv36rivzxWGgghacXt5ZiaJjqH
	VVBGfXm591/A20ThHPCWqWm8Jees5az9nUawjU7ZVmTdROLmn+dy8TR55rXN+j9L
	nqH++4GZQbX4etCtnkAUDol2pv+4uP12GxSIzZ2IjEsNhPiNIoYuy66LSQs811F/
	saVfY/NlCRUUUaZaRxu3b44Xj3YxbJm3LFnV+cSmoBcQBaLZu1kEqhODm4trUcB9
	Ah4K6y9NDB1ijXqJIYj5DC+KruGbAZyBGuD6LpPwTELN+m9PuTz4O1vYLMnZO1tN
	hh8xrnnkd+FaXeASaSgNq6Mjme4jFS1xfHzbWCjpKTo3oQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh1pk8cau-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 15:25:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c741b950511so2426324a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776093937; x=1776698737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7S+vUEanThPK3tKQ/ENkOAhTzWh25gKbMRUR+Sltyg=;
        b=F6OfzxFQRCgkBUuUnxW7JoUJ2Ljui5FxM1Go8oqAyyrUBDTsbJ4lS1T+UB9XIdrOx9
         7VT4AlALsxzsJ5k6tSDeZqkD8Rt6fWX5aLvmst//EFamVGW86a4fytnXv9wLrhB5bFxJ
         xkH+1wzDAgZVhUdju9NtkUjeLo+efN9JUZG9ivSW1AeTXWDjfg7e/MCPXSQQMpp7PX4I
         FuyYsmIz2ML82+0jn9M20xrMI1x+pSTbN7HTwaiSXJlL/QMs1dsxqzGzPma3opNwLRJS
         FDDy8cju6DhsDTUDX1cgVY5HWJ7DcCEiWYCcFNp7seZgYbK8Qi4pvJQEbrUAFXOnI/Dr
         dtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776093937; x=1776698737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7S+vUEanThPK3tKQ/ENkOAhTzWh25gKbMRUR+Sltyg=;
        b=YSSyY7q6esSPchDJcy486AElEzN9Pk84Yj3gNR+zyS0e/aHEKy3sHvd/J6bMP4vOVI
         hrTSbx8WpPF3IKxvJZ3GZBnouNq/0ABAnKCZYIXnN2uKjFBoGjho0ULmP4OPv84N8AXd
         AuKDP6AAkAQ+HkpxDcHouLpiaoSkzmKJ5uH5UEjRx+T2ygUh9quxrAdpOBAxxLLkdJ0L
         DuLqiYLZ8JkX4xYL+K0dy5STGgTDFDm1sRfywyxKfEMm6BwDpEGIHmajxIG651DxqCnG
         DfexLvuyr8q/0zxCD2/ocIEObQ9T7OlpkpIthB/qOMar3I0+gEIkguusMv1pHrId4QF/
         nsxg==
X-Forwarded-Encrypted: i=1; AFNElJ9hqAq/HFw19e1hfVumri01iNlVxOwbettRVJKSoGtYV8uUQC54/893W+yzRkK4oQJKgZV0E7WhzkpK6JK2Soc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOefXxRJMbiONqO9+oZxofmphd60d2sfhvnS+gsGzB7juGG/jY
	q6mWRRPDIbvS5vJvFkZmh10JmoGSiX/MPmGSR0TN0ThWiffnWMRe9xf45DQOig2zBWaESi7BP/d
	kZOBgbFnrjp7Ju58pU1zpTWpX+OFNxLuX26ERapCubW5ItFm+syn/49WkstgAwVKkcyqy1+g=
X-Gm-Gg: AeBDieuBAdt983cA2rje3+jcEuDbBh+nORTjZZsxCiZ+zm3H8G74vFVH6VtogG6ZQgd
	VTgG2B91jrZTJif/sPHGC3WT8hzPF9d3n3nk3GyUJOB7L178Nfn/zjDDM8gMaGXNcO+9xeStCKu
	5FqDQbLNvqR4DcqBZZDDH+rMMI9BsMhqXCU3WXHiF7eguTtcYbg/q8Y9l8JGSCLSgqn++HVet9j
	0G8YGNd8eysVgNdwLfF4cTJZ/K8yxI5fix7XQUfiet1wId0AfuEIX0clysJZJaYPVUY7ND0S0yk
	mL4Aq7pTmaAaJLK8Y+4Ko417gpLaNmK1Ts4s2pvxlH1LT/ZT6NuWfz0xtaDyESkeMUjMHKDOMaV
	dV2A1K3lEkqFsK0JZ7+PJJkgteMfsSgPJg96MaAIQ4GgwrfGD
X-Received: by 2002:a05:6a20:7f88:b0:398:c2d8:153 with SMTP id adf61e73a8af0-39fe40e3b2fmr15011290637.56.1776093936885;
        Mon, 13 Apr 2026 08:25:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f88:b0:398:c2d8:153 with SMTP id adf61e73a8af0-39fe40e3b2fmr15011234637.56.1776093936300;
        Mon, 13 Apr 2026 08:25:36 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ff41dsm9633095a12.2.2026.04.13.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:25:35 -0700 (PDT)
Date: Mon, 13 Apr 2026 20:55:28 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20260413152528.muemkbfuow2qg3ta@hu-mojha-hyd.qualcomm.com>
References: <20260407-external_llcc_changes2set-v2-0-b5017ce2020b@oss.qualcomm.com>
 <20260407-external_llcc_changes2set-v2-3-b5017ce2020b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-external_llcc_changes2set-v2-3-b5017ce2020b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 2xN2KBHwt81KkvNdwCa_ErMMkJlIOVhH
X-Proofpoint-GUID: 2xN2KBHwt81KkvNdwCa_ErMMkJlIOVhH
X-Authority-Analysis: v=2.4 cv=BoitB4X5 c=1 sm=1 tr=0 ts=69dd0af2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=wMJL6MW5WnhTYwIOHwEA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MSBTYWx0ZWRfX1XamucjCHGUQ
 r3YBT0Ukq2L4vlcDixuxo3sh+RUGorONJFw+40J3dCr68JaaTz4jhTux4VDLAvEbFpFSFJMv4WD
 zhK9eGNBjgXuFh2mLHi0dSEAmRS+yRFKsAl8+E4POxzSaN8kd5zoJ+CSX+HxOG3pkd2OLs8wRJ1
 UiWNEQdGbbPNyIa97x8DhxkKKHbIHew+4o9MTXPz9oyVIKFu08St1EUY/Stwc8Y154keC2/0xkq
 6Bf8+vG9paaiOsP1wsdxvXhjDsJQyj3dyj0o/UsmAr6bkOXZ2Yh4R7Ftw5i2NXjzEM5lhIVbTJ/
 +FqVSzbNyYHK13ZnZ2LlnfdGY4DspRqtulx4XYtdci/IY8KCkicgKCpU0bmiLvYzSVnWkcCQCpy
 HajyB6dem4xBqVoiOcnJemcDTVcHYCeMiDb49TARj3uiHCvo4w+VSA+xSWYejpKqZeDFW4V2nMZ
 UOp8c2O3F/VUB9Dll3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130151

On Tue, Apr 07, 2026 at 02:51:49PM -0700, Francisco Munoz Ruiz wrote:
> Capitalize occurrences of the acronym "LLCC" and "EDAC" in comments
> and diagnostic text to improve consistency and readability.
> 
> Signed-off-by: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This could have been sent alone..

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha
