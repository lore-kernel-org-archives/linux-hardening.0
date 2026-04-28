Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740BB3921ED
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343845; cv=none; b=KyVEWTHt1es4xSYHIGsTe+rHECw8Peot9NJ7j5C0bfBm0gg6/8JfjK4lyZxTPpIYbLALLm/oVCvTm1yJGBrrENTei7TY6RqmYCy/WlNhApjxNKFcNdMq8VdMu7lRm2eqvUekCv+rPxS9vYQXSGG+Ou06YEs8lI6eiYz05KYpdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343845; c=relaxed/simple;
	bh=vMLFJPMIZIbXRHwQOU/8SMObup79xP/4+Md3wrYjyqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttyDPvgfjXz89XpNxjRsyDHkFxIlD0psdyEiV4oXWNvrKirOyRfNAnZiJcW1SZc0B2KiRGYDNYRxP/wshvmEsjj2zTb4A0b0TKnelAgGpimYSlOFBxLySAeBzHREsC8Br0f78rUNAfkqngaGOA48n9B98X0tEPSNvg3LyLnd+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XkULG0TN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i9kNPgvf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XkULG0TN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i9kNPgvf"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RMTJPD1625047
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 02:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5XLBDj/bqWKMsmb8JuJKdh5tlBW1FdM5yrjutqkC2sA=; b=XkULG0TNT66bFe5Y
	9T1dh5bDWjkdat+p02yP3NsQR59f3kSgcxIienWVHATMlG3UmcDioZKhTHpYzYtv
	3ZEfiB4RP+Be/1nneZfygxRx4/MNHEpDlfgq390aOUs8c8Bdr5qxbDqg1n/U/45K
	6udtQWUxf/QqAgeCsOfjyAiLDdLNtbi/u83aNCBwNn55TG2vx9WgvemiNjGdlEHC
	AwR2Wy7m1tfbaDLXxn/QzrwL4kLjdBg0EtmGOA3gWNp9PCmsXOBxaY7/RC7O3ejZ
	coBXbU2zR2xxR4NB+PWC1T737LFsOPpSmcR5G/ExYubxdp+eYimq+QxAYgpGO0Xq
	2PW1Qg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgms8rsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 02:37:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c44bf176so12776357a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 19:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777343842; x=1777948642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XLBDj/bqWKMsmb8JuJKdh5tlBW1FdM5yrjutqkC2sA=;
        b=i9kNPgvfim4Gebkq+scpmK5nguVQhBDhfdiuMwLNTk7wc2EmuKnlQ2J7ht9Em7seHV
         qqG8CUoeeUhxuCyDUO8+R7cYyLgsGlCrQDeNixPjs43jEao/kj2twVAfEamqtwUVvjil
         WebMN+S3zvmLQhYyuAkd4P2myylvNFf9DTcwZXbKRKfSKuuA/gN3K4PhFniDo45ntYXU
         c97yikWThDH4N2qhUPJl5Mm7UTH7SWlYjtK3XmUnvPm+9GfZYFJ58rsDe3e0nVTz6cIk
         fJTacMRWLhBRRKuEe3qnAFAJzuiQTGMPMQkcKrLk7xOmEchQ7vam2RMZN5flGEhZCP3e
         aEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777343842; x=1777948642;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XLBDj/bqWKMsmb8JuJKdh5tlBW1FdM5yrjutqkC2sA=;
        b=Zdbf6e10H3EvEQwQy3DEl0sUz8TaOOmbVnmTyqD0MgUEw4mPTKJJI4lERF6DG3n1v2
         PwqU92aEqaczwn5fgbTNiiYPzni6pRC4voLK+guenOT5POL+5eq5YQuQYXdQjspny5nj
         q1Isz1ZasyOs18Ca8slgNr6J7Zllz9o2hIb2j3rjPaaZXiKZre3V1n/2P5wR6W+7xz/M
         zvjmH2EwAF7wazJ6DmjmrFVTPFXuetX1Bm36Eltv0BHGYAi9qcGRtouw+5Dh38+kC3rY
         AcP+2K1/Eb/HpLtpR3HegVqVq6URugNQ38iexDACboe3ZayxaCVxycPHSrRdt0q83YuR
         nsPw==
X-Forwarded-Encrypted: i=1; AFNElJ8S+XaPPPui7VwSEw6f6VncZUtEFsiMoZ0ai8ktQtW8X/eO1yDCFGVoOlBkP0QgLnN/B3gNxokVGRjnbWJQQEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5T2c1zH+yVHowFlddfgm1PUf/7XT2Rfi1RkONZOJaBwkK4y6
	Vwuya34Zs/S0oeZLmgjor9F5+BmOKdWuC7hPsYxBw+DsvHosAYJUo8a3mtJWkxzwvWmMkdAnE1e
	6ys4IH04K+UVOIyKiCPIEhpgDDXWNEfJi4OEQPB0NRs1ZJXHvyFOrgS6yNbGv5EJYF3RhOVs=
X-Gm-Gg: AeBDiesfOxXI6ac/xs/z2IsTpUDcr81EiY570AYs2GGD1vkt8WtModWMz/PlJ7yR2KS
	kuhszovzK+JzJcZwpSkpWtYHoRojK0D7/TLvcjLq+EgzT53LfwUHou6WBbI+zWyJ2DN5siB6Ddu
	2PKwUIjfInh02yGG3Aj8FZHYB6hW8ztMCjs9n7weWWjZJxK++RR+BISbEriItBD8For8h19Mo+o
	+lJbEJmrT/DYwBVCibL8C5w84BY9WM6E1jAgGdxcPKERCNBmunD7kcEOqASD2enorVxSFEi4ng3
	0EbKNGOiQKYQueSeRcd6bnv60NliWL7t8vrGdFoiaSCg7s383YvgGs3g2YkYJxtpjtVfuSVB9VI
	DsG2ko/nMyKmbFJ+04QPf3Ea+xzEEmN6gBk0wfps2tiYDkncjim5yzNACU6fnAV5stAAmArRKz+
	pVssAKOly/hSFsmzargxv0pePMVJoFtg==
X-Received: by 2002:a17:90b:4f91:b0:35e:5051:fb18 with SMTP id 98e67ed59e1d1-3649206916emr1071940a91.26.1777343842134;
        Mon, 27 Apr 2026 19:37:22 -0700 (PDT)
X-Received: by 2002:a17:90b:4f91:b0:35e:5051:fb18 with SMTP id 98e67ed59e1d1-3649206916emr1071908a91.26.1777343841595;
        Mon, 27 Apr 2026 19:37:21 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490cb3f98sm328583a91.13.2026.04.27.19.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:37:21 -0700 (PDT)
Message-ID: <263f598b-93e8-483e-95b6-3ba9b19ee8f9@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:37:17 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 ath-next] wifi: ath11k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260421231205.77361-1-rosenp@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421231205.77361-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BaQEgxLkg75_4P1qiMvpmveMMU8pLvJX
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f01d62 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyMyBTYWx0ZWRfX5CKAsClb39if
 V9iR/7VsEQm6CLehnkPOMIyaq9uCmJRZczBmFRs5Byr3BJ7m9wKv5m9fYZqEq/sl/ZYz0+uEXDr
 R3tvM/b/6pu9STDDlsyKnYu+kRNIOznaAvoJwrLpZXajbLc1YkrzAJuCradq0Fxhg06VIlqPDZr
 jIKUvBHReTLIJmHp5DsDwyl6/+J6NN4f5xVAlRjXBbKlr1npKJTasFBuHLhDGLkVjA+ZANuZR9R
 FKWDwvD4VgaEavoXPiVpNOn834H4zMYJOfdTBllDsr9Uq/m9XcxREpNUk2nWVW7P/xmJEQ0ML1h
 xBpveTYUCfdinwhK8uB3g8M8Gr1YutUyDmm05yr7c5i+VWw5Yf+pTNtXQSywwh2tYysJWxQdhQA
 2YiiaicocL9gJPSgb7sDdItd/+wuBr2yZWorArIWv3Ow7NHtcWzmhlf7NKCXYeKEXqIWqaWAwFW
 4K9kFvIJStE/dWEM3IA==
X-Proofpoint-ORIG-GUID: BaQEgxLkg75_4P1qiMvpmveMMU8pLvJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280023



On 4/22/2026 7:12 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

