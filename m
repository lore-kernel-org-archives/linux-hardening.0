Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7948033C
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468051; cv=none; b=ihYV5Dbjv9Na7638kTdJorGOk6PM/mQQ4AHY8C8xUIYV3hqOxAHB21hAuXJeLf50LaaoEL8Ok4+nHf2ciMPd7ku2f4jAERV+2HCh4I2ey2icXaVzUIVhF71vHzjbWdS2okEnJ04FJcTKzsgQIjGhn4ILORiIiH5qfXm5S+NbVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468051; c=relaxed/simple;
	bh=ckBmQCsGl4i0H5swMQltGNEvLAQ4QNaTpkBEqzAPUS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NApUOHIPb/c/4v39sn2sij+X0mPewrsAjYgVwJib4Mim779XZQlRJqZC2xXN/e0tt5ztbvxwLIeTnrGrdbFXhIz4+CqEMGSXgqN3dChj3tV7AfUvjErF/8jsJjS06iIrHmT33vVfgmtnlXKmDmFf3Leawlq48I0/IdBqk2giYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bIwOYd+J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iMWOBRX5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bIwOYd+J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMWOBRX5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F9h4YA3317456
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4B5u4XhHsQDHFwAeN8RPYZsJq7AgzxHPXAAIftTImPI=; b=bIwOYd+JYKFSCYrP
	nCi/eAq75tXkFs1ZYz/8MAhCy2Nx5mfuB+SFhJqYWAdqO5Ki8XFzECuVfSnWzAuL
	4thiNLSTzeKsrQH8W8M7dEv7sk3jh/6jCBbsThaG7649O4nEo4YKTFQMFhfbymVa
	5/Ra+rKB114Ves5BkmJ3Yct/+R9zfzlYATVK366v4VWegslqrg2Cxj3wA/GeutJ+
	ZWlEWlB1EpGpqgJqPR2SIE7wQw3G1l8luRBwF010kkya2wbCAhYUVOKD4FWDU7b6
	TfjVDwIpn5KdQCHsae/OHIlHaGMvkewseomzIlAx7Aykto9YgL2jjaR+TswQDBU6
	VQ6W7A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq38e09sf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:27:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52fc0097865so133713591cf.2
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 03:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789468047; x=1790072847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4B5u4XhHsQDHFwAeN8RPYZsJq7AgzxHPXAAIftTImPI=;
        b=iMWOBRX5UngFfDN3QChfulAhu4J2A54oBjfGs0tjxiYwsy7VZLmJCt+adN8AN8NAsi
         bPwvMUN847e9x4RbLSaYEs6caefQoOfQ/uCe3rjBop/FUUhCJ2IJH1xCmNun4cxF7MYj
         FqiHJYckHLnbb3YUAKLeEPWV2LoG1D/7tWTcH3iJT0WoUadgRgXa8QJcbXLabxWzuzJf
         j3q5UCU2oBq+kvH0QfdeQF8gUze7mYUbfBW7sPCNhfgKxINvEaojEQffDMMocydlPG4h
         JRnqVhKFw2f6cbl1L1BDsN2TwDF/HtCSr504OXqMDqw7QZ0bhPaUz3uPnbOosp+KiN6S
         1Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789468047; x=1790072847;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4B5u4XhHsQDHFwAeN8RPYZsJq7AgzxHPXAAIftTImPI=;
        b=cqKwhw9CGBq40pIqnqMsIF+23NknUy3+mDo3mDZxSlQqQmX20i6X+WSio0UMdXmurs
         uouRPbL4h0uHY6uaaVOcNdgXwDG82TmEkRQoHfoQ5RQZKCbu26eD+px1DF5G85uIxkpL
         oXOuvOZUPvmM8CCa3kgW29P2FLWFhPudVYaQZeuFRTFPXjYZzwm34QaEjwNmq1BEIA2S
         NveUJErkz3LV5qAef6RVZuPXgdt88h8hKiF12hVnQe5aphLvjA/Y0kf8QEkXn9FJcFaN
         tfpqGYtlVgLfHQaYo1pRBAnhYFwqYa5nPSSkXNWx7oI/wsLe07Ct0RzAzQV0VOfHm0Oe
         USsA==
X-Forwarded-Encrypted: i=1; AKwUvByFuQStna0Bj+3e0zk5aRfV3fHx2/nB4oAjkmNr1UQDPllexKB5mEAdaM/zFatszmtEVNxDRleyzN59w3jqkoo=@vger.kernel.org
X-Gm-Message-State: AFuF++nHKk5pUhpp4SohLAy0EttReNI5b8cxBUewaj6sBzSEm/GSehft
	dNeLhGODt/RvwdaAujQa6e+WGgKPAJ/zep6xQHWgXGnzTUJwtWS+np+4cy20KBc21V5ZBslNWnT
	0aUr0aMWP7uo+qwqEMCqpR6VdqSbAfQR5hzcpMILKAdz24EECM/Ch8lM1KgvrflSPNH8nM0w=
X-Gm-Gg: AYBFou1dEO2SvhNdL/eHKZSrF8nnCHw6m/vT9LJOCrlwaqqTq2IRoRlJKQhI5F6q1jo
	cMnqZSSFqhiYWXrnY+zLcT+9LcGjcTyzy1nFZHeI2xpNWtwFAa25GG5M/76Kexd8glQXOruLBhu
	BBnOBdzu2vuHVUgGWt5INoH8aLyl+1znT3yHNMswhpJqpTNRiq33dtAbjgvPM6grbKuCUKZWSEt
	wrVij79XW4wjHFEw3pIrdF/Em4NNVPzol4dnKIqzdNd+YR9Wi4Oa/tsmMOm9fPhiA2SP0YfzhIO
	tu8qi/va0CIzKkNJYfhsFuT6OWLlaio68lYau+J2Xm793PEwSqvOp5i7xdG2UkAADgI+Ennl14X
	uF7iyBe6bcHsNwuU9FH58daF8gq7dLCRtysO+c90ZBRR0WOu+f7CF79+tN3yq0nk=
X-Received: by 2002:a05:620a:2955:b0:939:8bfc:471a with SMTP id af79cd13be357-93a29bb4ca4mr921844385a.49.1789468042641;
        Tue, 15 Sep 2026 03:27:22 -0700 (PDT)
X-Received: by 2002:a05:620a:2955:b0:939:8bfc:471a with SMTP id af79cd13be357-93a29bb4ca4mr921797285a.49.1789468037445;
        Tue, 15 Sep 2026 03:27:17 -0700 (PDT)
Received: from [192.168.10.107] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6b6261sm71836915e9.14.2026.09.15.03.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:27:16 -0700 (PDT)
Message-ID: <0bef7837-9fd7-4401-b6cf-ba744f5beb58@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 12:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/9] soc: qcom: Add QMI TMD support for remote thermal
 mitigation
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Casey Connolly <casey.connolly@linaro.org>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-2-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-2-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3NFLQG42cglaMZ0pmqkJ6QOBdO_LXE7u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE1MCBTYWx0ZWRfXyA+rs57sHAix
 HdXcALVqL0pHnOEpMTl2dH0sk9xkr684x8CAVZQd5ZC1Wwh7f+ix6PFjlpS5c7wqfwidKjMSZcz
 JILtnhp+zdE6J7JIpW13SUXcPr5jBqw=
X-Proofpoint-ORIG-GUID: 3NFLQG42cglaMZ0pmqkJ6QOBdO_LXE7u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE1MCBTYWx0ZWRfX9rxQZxBEsWPl
 ndXiAPN01Pnk3InLudrFbdhJTHIeTFsC0d0IpgKOlqIWyopsuCXGjyrdELpJU6iN0wrKsXMLZxI
 bvXcqRpKlaEbCsIgng75YhEA3XO10tfu+NM3QvXDf5r5eqhurOIxvz+SXzJTDTUbYbYJv9xyFMB
 Sbjt8oxFbeuJUDX4aZwCrZ8jVls36mfTsBN8/xLfMhDWbjAhA8FfWtRTAC+7FHyq2rjygydT1i0
 Nlk8w4YYKqcnY13JjcvclmUU2956QdWqhgHqVfvq20wGAbuJmzAkYFdxRtwC4hqmTvuLK7RzRdR
 WNP6HLte6nj657pI6agJrAXVg5yHytNpC1fyu10fzfVXOPwxSQowj+M7E4UaQHLX/LPh6/GNXzj
 kD+nNWc45qvz3F7AJDpAvYDOaM+QBlFkQ/Apu+YQyQzjwSj15QrJE7vGxWbQxLQWn23xb+xx8Za
 7KZcvYeEDGi2TJM3+rw==
X-Authority-Analysis: v=2.4 cv=BswIUoX5 c=1 sm=1 tr=0 ts=6aa91d90 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Zce52TE6RWQhZkoPOn4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150150



Le 09/08/2026 à 14:28, Gaurav Kohli a écrit :
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Add support for Qualcomm Messaging Interface (QMI) based Thermal Mitigation
> Device (TMD) cooling devices provided by remote subsystems.
> 
> On Qualcomm platforms where remote processors expose mitigation controls
> through the TMD QMI service, client drivers need support to discover the
> service, register cooling devices for available mitigation endpoints,
> and forward cooling state updates to remote subsystems.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Just to clarify I deeply reviewed this patch and made some changes to 
improve the code. That is the reason why there is a co-dev-b tag but not 
a r-b tag

[ ... ]
