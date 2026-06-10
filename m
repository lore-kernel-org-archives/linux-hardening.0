Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE8395DA9
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084003; cv=none; b=FJYb+x5GGmg+i513+zzUtFkn7CDPhPkjxU300QKprONVQIPIi02vU6Eee5pzoepPZcvGeDlustte87TiOecImlj3QDW0B8iorlyZFpIYkGnDEdN26JM0iBxHYVXyrKjtwt/BIOVdT88w6+P+iKFY+Pm0hLobfF9/a8dUeccCOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084003; c=relaxed/simple;
	bh=dfWU5dYj3BQEe4knfdrGEtREOTcs2SuFMqVcgJeSZrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuhqgmIdSBHi3WXQMPjWd/vLmwk2KVxEv1sNe1fdK4dIivBeXlX1t7RLCVEYlai7gSkM0c5DDSfPUM5WJ7cex5eQBqZmfZowOn1SN3+HMQ8S+J8HFX1iOrIMRqONt5HxzynB7mjHVKVy4Bhcx9YH7ndDsFvXv0gR2ou4WksHDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CnPBhQxt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jb94o9ae; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnPBhQxt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jb94o9ae"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7i0F2991008
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 09:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7QtHwMUeXsyPxSQjQqL73zv+JFnpAINM6rZU7wAG2nQ=; b=CnPBhQxthA3sBLC1
	FtD63LOo6GyfL2cBmocXFU8Hot00Dr16VBheg2JTDSjEHqJ+sZfOsJmlyFE5MvLo
	0xGl0tAzlt10jZqRqVBFQDpS6btZe0zKy8Mn3YcLB6GxThPgOBRjW+eIAubdfa9i
	mKbs40KS89w7AJGqtyfefUkUWnH4+Micg+U9Qwz96h912eLrVi8CzqsdW4ub5Y8r
	TyUheMVvF2C8cQvcCITjcDwhUqAYS/N5xvU3kETbTougPQ9M9bvl5+nG5PNwArme
	x2z5KP9AwyYFcy2WVQHDKlAPM++3yvX36qw4Es6KQoyyqD8yhqUeNqPB3m9QGZ8I
	skxk8w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq1tg0wn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 09:33:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91571f0d3e3so96228985a.0
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781083999; x=1781688799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QtHwMUeXsyPxSQjQqL73zv+JFnpAINM6rZU7wAG2nQ=;
        b=jb94o9ae9RIqVfIwTpfm2XXGc7HA4u2rudwezfouIsBeXVxzglgPjot6n6G/KZj62s
         jem8YjL8kt5MeLsDTc72dbGmK1WqcbWFcUnSKFBgfo/5svum/QtarC0jfB3uNykP16Tl
         xXNNx6UyWwY0Nr30jyqfNyBD1oqIbT69tlXVoHjunOJfR2TIWcje75KQpoteYRynBK0T
         YDDFjflkn+S59UPyIjRiBolFTy7iIctTWxCbjbDcWKTNtMtRCmevcv0Q7rn7Ev0b4ZYZ
         i1uGda1shdHNUH/xGiEKdRJRBJ9Z4wpDMaVd7MTIjzVuTkW52gRJwAKpuL5kU77gPfIK
         bkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083999; x=1781688799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QtHwMUeXsyPxSQjQqL73zv+JFnpAINM6rZU7wAG2nQ=;
        b=kpNMJljD/4omxfA9N8HDL1BTPIdXh2k6YbJCr3qLQJKU0klQQqLzqFl651A5kmMie6
         3KgXQjQ6l4DQ5Ktw4j7/gIxgULZ3g+KbLwuna2JQRRvZUnkZm77Jc72R3mIN6OT18fJn
         rHGGHvHzIyQEiXN4OoVnzD+EvUtW2q8VZoTzVR4a3Upb31cdP6Ob2Y0t1uUwHGaRVBy2
         OTm5F1NV2J8qmpiEa5NWfrjn7AYsHLVkkjQQBXend/3y8HJn6GuOLKbRDQztIIHJUsa/
         N35KkmFWz64/bZbCaKQxTlwVRH2PFtBhvBfOMXFbfb5CnDb79qG1p6irihCzPH22Jfh3
         J03A==
X-Forwarded-Encrypted: i=1; AFNElJ+a3YmC9CRo2w+wMdmsvRXn2Q96eHout0OjkmJffQ4vz+DW1T2T5KPbZkPAaEjpX+K/OxmwWwWjbPn33EzlDYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymL+5k7VFKK/+uBmMl8oRKFQCoRZA+bcd72fZ0Ughjr0SWYB6f
	fCnU11lYzPSYScj3cEVMu32kP0zVv68GtFbXwY8+VpDeavXQlb/gu9zhPVnMHT5ufo2Xuf+H4RZ
	pZorzuR/WjMJOKaAl4qBGoXtHfZQta+FUIqNgc3I3UB5EfYKPTvSqzjLn5YVaLFIPvQoMADI=
X-Gm-Gg: Acq92OHC+BNOI3JWVrlJFBkdGaEk2OUwtCZWpPsO1RGgZJCWi1EpClWhy51S95j3SfV
	JabXqlSDpt/a9ZQ7rXEpKF1uqOgob9tj6beTPzUhdjruDM3AFSwS0XDRVLiJ4I7qOuRKdL5x2xB
	vR3V/e6ISrn4J/y99oOr8k8+8hI6HC4OybEvavhaN33QrLuakXuAq6KUyE1EuTEQj5IVtCB0peJ
	TdW9fSyqWTzvAWXYiqfCmXvKmdW9LGwB3BjD5O326WA7ppIbxNsLdM0n4pGkvx6AyaXPfr4akzl
	49SRc4VNn2vqayRwa6QaGLKAuPcIJlU/WpGPCDG9bFyL+anWnLJKHLP74tKnyPAuF7kW2M+xb5L
	Pc2LsmrgcDKNIwHDjxrx2dd995ZAgESIJN9Ll/rzViDGHe1jfOdZCD2QT
X-Received: by 2002:a05:620a:2a12:b0:915:6433:2599 with SMTP id af79cd13be357-915e6cb8633mr659876585a.1.1781083999348;
        Wed, 10 Jun 2026 02:33:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2a12:b0:915:6433:2599 with SMTP id af79cd13be357-915e6cb8633mr659873685a.1.1781083998886;
        Wed, 10 Jun 2026 02:33:18 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912365bd3fsm6107733a12.5.2026.06.10.02.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:33:17 -0700 (PDT)
Message-ID: <ca6a652b-b13c-4b28-adc2-3101c053b959@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:33:16 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] interconnect: qcom: simplify allocation
To: Rosen Penev <rosenp@gmail.com>, linux-pm@vger.kernel.org
Cc: Georgi Djakov <djakov@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
 <linux-hardening@vger.kernel.org>
References: <20260609222454.37352-1-rosenp@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609222454.37352-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wSvuPhsYELa_CNpm3dofNA4EJUB0PIm9
X-Authority-Analysis: v=2.4 cv=dLmWXuZb c=1 sm=1 tr=0 ts=6a292f5f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YpBc5yRqulYp3uqBtjUA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4OSBTYWx0ZWRfX9QGw2nw8LA45
 ODROq/kbZgDRmQhbdZ/xla2my/EqoiIuUf1iQ2x2IrvzL+SH//gPnKmnBaKcujOhSdkddhWFssy
 no6iwCiQozViff4pKfDRA6mLnDdFWHVdplq/Vi156TvlwRvcKWyuxxchQnE+ouxLgLrZQl6j3Vt
 b1pgc8AVVFPDafJceBNh6C78yytVPLb5/4r40Hd8K2HwXgOfKbJppkEM8ERFnyLnSkawaWLruHs
 kwGUcD+FAjlh0N9l/x7xqbhKDE4bYPXc51L7p20AWjDdwY4I9UqlhI/v2INmn0G+6g+pdvOUv/c
 m79Hiw0fJ5YEyhD8JoJypNm2l9TO+inB0oPEAlUoqW6/mehIFu0+qSyipuuNFBacwyolNGrh0HO
 A6JzZbdwQzw2AuCURHBXE2RweJyEm717o+4Ziz87fYg5YaAFEcCmc4L+VzVWuMVeBvWly8S5QRu
 OGO6rid9//xYYQ9fnPA==
X-Proofpoint-ORIG-GUID: wSvuPhsYELa_CNpm3dofNA4EJUB0PIm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100089

On 6/10/26 12:24 AM, Rosen Penev wrote:
> Use a flexible array member to reduce allocation by 1.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment after allocation before any array access.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
