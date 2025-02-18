Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1F26F447
	for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901377; cv=none; b=AVDK8Q5YcYFsb4c/LB3uI11ODmJnNs/cs9SIeXjnnjDBnwBqk00xK1UH2uFMVKJVO+R648fVTeQTQ3JsFXkIxS3BG8dHAbuaSTUCdGuz3BOB3msDmMUQmHmkFr+zq4v/ejyqImTPN8tNlLxu9sNbJEkH3fbjHNW3PfIAAfq0sZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901377; c=relaxed/simple;
	bh=oTjuUiXvhzJTYfdkErAeQEBerMb8kTrvk9je9AIL49A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D86Dtt3HDte9kzfVsA0Wem0GWLOaed7mr4RY5NIuUDG69EuJrbi3BA1AMZNPMk6CvDUjQJDgkia6Ag3OG0D3DdP9pvLUcAx+HxWF9/SVLljVFFU5OQWBj12SLMnwt5O84mO8vsZUYvjCdjqn304YGZscIHaDJ2IAjBRQO8yfrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maBnwhyN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maBnwhyN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IH1944014472
	for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 17:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5MZEcgITSiiKIsZylFwsENK2tYufFg6kig8Md0m03l0=; b=maBnwhyNo4vyavOI
	3qYJlKMw4oixT5ZXQ12wvrrJ8n48BTX4bMntxD7JOvvb3DQrVnPiuCHb5Bhskv+7
	c3QB1jED8ltc3AQeBNJagJpsLjNj9/TikfnKQVMD7Y5ZEpsIHfzezgks76us3eZ5
	vtjkZ0lfXIuPUHDpnYI/LN964F27tQzJ9XlRMgCO2wPegvmraveJR1Kg8vVMs+Rv
	Cqa4VX6HiR4vMAuHb5seMEOaBtfx5y8hpRCcN4rrFU7pxWNlBSUFHLHXrs8SviTE
	N7fR07kLTvXIyRzmLYhs2LSgpQMyIb3+0aTvhh3V6aZFE5x2nA4wYmZeF1hdZ835
	os4w9Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vns91r4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 17:56:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc45101191so5990362a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 09:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739901374; x=1740506174;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MZEcgITSiiKIsZylFwsENK2tYufFg6kig8Md0m03l0=;
        b=G1jDl2Gm6iz9g3WsU5WbJBp6OGWU8PZJmjPflUAnMcfn5s3sgV/vvui7x1/i52o/SW
         v8+6QzM/C33nlecNSn5U4+Kh7soYzfzuxkvrS4d1nqpN648WUiVVSQA9NFnWOpTC0N60
         tACMzKCQtd8ijJbmCudvIix3gdmTh6GiFpovH93PMaNYSkq2oSk4GjDfb0zmtJmK4CCc
         YoTLj/MzXteo6XoZ04R1iKYY+yUVO1GFN217Iv2YtsJdzF3cvqbAk2ygw/UocSmP3QfC
         sQVLGLTu8tqbLAP+PhowfgU7Z8NeAjgXw5WQWQsoBuipB9/wwByCQwSkbmzRzrMhgWyk
         UHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM88q04JLpNf8RujUQnEEc6ioSTF2m87nRLqjZdo7WjY25bOL2i9G8/ciemMGzBQgB9ul/OZRlLiYoYD70Ep8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgaM09rKr8kxo66rlOG6Ht8oKju93UfGkd0DB0npUCuVQe+oP
	qy60zA60tKrg9WE4aCTa1yEvuOpUEOafukEfpRJx+agSSlYt+Ok8XsoUhPGWN+4ch9GT78v1TBE
	ckf9bLOAMhusxUiCuAELz4fTKWMswb++Qiq78iOxA4Rb0ZM2oJRhiN0/SoXT14IpN/Nk=
X-Gm-Gg: ASbGncuMR54Fvoae9Rc2VSDb+jCfwG/lMEfYIK2JHZ3kcTv/lNBiD+ya9ngv59z/CHW
	ZyMq7fiCMVhDSbDRX8akb0r3XHP9vBwGYe8ZRqBLOanjwGHcYMTKsLB+ESDcTqjSzYTgzC3wpF8
	+CrGuggMujP/A2O4CEDPqwBjm1sEsiFD7y9jqPs0WDrFTQt5x6Xnx9tUbiTkGkX7tIYpBw8ltPW
	IL6WPkMDs4+hGn/Rv1BQrOTUDOI94d0k4WtsEpRAYM4ELMwCP8+vi2d+lOsdCce/XzVI3AXdPhJ
	B9yPK5o2i23vMjRgD5uMSb/ym9xbSIwlxYuRaU8I0Q==
X-Received: by 2002:a17:90a:ec8d:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-2fc41153decmr20652831a91.30.1739901374480;
        Tue, 18 Feb 2025 09:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHRnoQUBRepGyq2OMwaJX32opGFnz5QDIQdI91vfH8K801jeMK8U9QrNGbTTdrdnvAPHaa+w==
X-Received: by 2002:a17:90a:ec8d:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-2fc41153decmr20652787a91.30.1739901374048;
        Tue, 18 Feb 2025 09:56:14 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f698dsm12342252a91.28.2025.02.18.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:56:13 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
References: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
Subject: Re: [PATCH v2] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
Message-Id: <173990137296.1304166.12952412255986592297.b4-ty@oss.qualcomm.com>
Date: Tue, 18 Feb 2025 09:56:12 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: n1lTdZ2eC_3e-MEg7fJyt7xKgnXsP4OO
X-Proofpoint-GUID: n1lTdZ2eC_3e-MEg7fJyt7xKgnXsP4OO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=441 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180126


On Mon, 10 Feb 2025 21:49:41 -0500, Ethan Carter Edwards wrote:
> There is a possibility for an uninitialized *ret* variable to be
> returned in some code paths.
> 
> This explicitly returns 0 without an error. Also removes goto that
> returned *ret* and simply returns in place.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
      commit: ceb3b35f5ef4a0c490f54eb8b53075fd83a97d11

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

