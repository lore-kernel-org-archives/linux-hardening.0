Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE883BC672
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218782; cv=none; b=gMj3PtYEYtbSdq0y8NmTX2fZ6hjG3ftCXYbcuzLn57Ev0hoEA+wn+SW6sFLv2vzEZbnA91GL4VRzGx6x/Jq+lgKMXiv0/LlHDFQ7JIUqrr2hgQx1OsWNjgdqcCio4+pnMIO95slTRdVOYixwIPvKsQLyGSmT50MLA2A26UCmf3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218782; c=relaxed/simple;
	bh=KcBBn14EnBGiMW8fGtck7ytZ2j6VGoFJsjejrPDO9dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhTmG8w5gg5FvBq1Hy1RH7vxzL0CFV0IW9QLxB62cZJ8zh0K42+ujBTLqW1hkRbxQZ+88B5gd/YPVIfgJSVFVJcalL/2s+CXgav40lfmvMQD5TwK4pTKXmabIx4CyfaOkDUusaSMR7nUKeziZG40agH0THekLPRRFpWCC1qxQLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C0kUWn+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rve8oArn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0kUWn+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rve8oArn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B7Q8WM2030909
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 08:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	unTGgoVWUMk5eUcsaRXhcn5zZKpeq+dp2FcR+QUVi+Y=; b=C0kUWn+ja6EKnfEx
	Ssvmi54AlnPGZih4GO7YQACwjYf9gev2XJpKmjNg2LLTkAi8Gox8skH6D/q1kbfH
	YPM/YlT3mkJw0ektRGRg007ef/Pg2iZX+76EXpnLr0W+vH+2gd4N5CC6P0d+emfN
	c2j9ZEwfLeE7/xHkxT7BJl4uFsRXezaDfUws3gXQ9O9SRuzvWYy/rNUEnuNjlLlv
	oUxjBc7UGasQ0n5pHD+rIyvs3ccTWW6e5TSViibc20yDbxcP7/Q7DLXbq7BZ4wNp
	y6fHzeD1OaP7n+l8CT2MgDsVSBWB4STALBCiFmvY5qVtjvCnoLu2UBkx2AaDPqnK
	q5yNZQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu40h09aj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 08:46:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb706313beso1839300585a.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773218774; x=1773823574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unTGgoVWUMk5eUcsaRXhcn5zZKpeq+dp2FcR+QUVi+Y=;
        b=Rve8oArnOVYj0Qb88em0r+/gohzm4kyn2E8PuUxJnq4fCySScbni/ft/CaXP/Bwc/w
         UuWFA7RexC/DQvY5DvmGE75MURwpbGR2HbeQoq9JRHWUGQT0QSWjzb7RD0DbnNHdEQF/
         TzlZ2rI5ncn+yosop+SHFvEywReM7JdTXucstj36AF2dLGEEZ34PkOuLoBjETha6S6b0
         URjpdKArznyWxTZ8e5iCu0fizHAT8ANOWWLluhGvHUyu25oGzBuzBdGCv8pi7i3psTa+
         y5AiO9qUQC7ZaImTBac0FroEVW+YFAKpimUfvIOevJORZCGxpahCurU3n/0qHlHRp3Sj
         4K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218774; x=1773823574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=unTGgoVWUMk5eUcsaRXhcn5zZKpeq+dp2FcR+QUVi+Y=;
        b=XdpFFwvMtCU7rbXB84TwyFT4j6fDB2occHABnlZT3nzuh5OtKa3Xn8fyIUgyrsAcXi
         8sY1K5IdjPyQFzWDfrDaEAX/DE0cDRjS8xE7XKeJUa/hg5f+QAo26EAOmMaV/Uvt/tV5
         yTbk2rU0qaXewjSJue4Q95Ufqqh1cMwPQvFkgaL1bIMuso3a5VYAKvMylmFkPrcp29+O
         nfy046gCwh5G2k5IB9JWCyJ92NnytZ43qIg5VMMUmC0jln3crzYxf84Yzf+NkzpCchok
         MQvhVyH2mzjJEuA6/Wn6Wn2Y0DdZaNyeGtP9qbEEnMOS8V37ioSo0phJyg4ZQE+gTNEV
         zU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5Fa8Eq6wTBHf6luFfG1emGQR04LIlVxAeMqLJsjGbCqT+vGtpeuVMRESwWHcVHeXrZvaWFKvYgVr9NrEpj7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyszBAU9UcZo+z4KU2Y0mwOfQiWyWp6+mVSo2fnhiXtUrCkiW
	a3HwS+JLo9XfzjinLpVsWQ+uDh6N9Uis9SYtqPJaSnR/ME/6+CL5u2NWxlfyXYf4d1Hho4DVXnD
	lNaqbB+I/5Ut/mL4B+T5rEs1QtrAdY6dXYg6RGpj8OqqLCdjceg3X+tsnQswW5XJgibzkl7E=
X-Gm-Gg: ATEYQzzcSpkolFwvOPsTnBe+2PSkV9Rz15x8dnoJTk3gi5+BSjeD3aqoowIh+hR1kcy
	Dmps7Cyyr25z0ONPAjcOrV+6+KDcEsEnmmREObTYfA67Xzb9Ns1127aqSzrdQeMlwo4M6mPavY3
	QvkTQ7EdSRfV3NhpJsqbVcJ38s75j2kPwgsIGF4mVn/oEwXcOqX1shMJjpW02uNnp6Hj1oev8CT
	SIOzOqQxOxyJsuiVa1EiFNc185j/r45Vs9ypIbmWonl0XFSD8gvs0VlIBCxfiSCvA2473pK/nBJ
	Q9VReczKlKA4I95AkLdWqphYLSckaaJ12VDLoNkbomR3q4q4kKk8v1tRzux7uDJnYdK9cgLpXj9
	bRuHf3nBuI6NWhoHHDEy3hyYjVf40RFNKV/iiqUMfffl0lvfIQIM=
X-Received: by 2002:a05:620a:4009:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8cda1955188mr216963285a.21.1773218774455;
        Wed, 11 Mar 2026 01:46:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4009:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8cda1955188mr216961785a.21.1773218774031;
        Wed, 11 Mar 2026 01:46:14 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1f4c:200b:aaaf:c666])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81fcd65sm5503816f8f.26.2026.03.11.01.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:46:13 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linux-gpio@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gpio: bcm-kona: remove kcalloc
Date: Wed, 11 Mar 2026 09:46:07 +0100
Message-ID: <177321876119.6763.661602970741238772.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311003431.31881-1-rosenp@gmail.com>
References: <20260311003431.31881-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA3MyBTYWx0ZWRfX30wdKl/tAD+8
 pNAoNLoOi8mF2w73SDT3WffyrHusKrnLM9PLigUpfATzenms4R8Zzk/0gDSp9OcfmHaqrVEY2pp
 kTYOJ4B9IfubIlOUqwlNEFjToa3KwuKsqjSP9DvMRBqtNkwMK2lEDIW6SSBBkS1QSn5imFvX5mD
 gO8aHt5LYEFx41MCDWct1YQp73u2Pjj4Hy6i/qChpaNLGzci7iz48XRxZbMre+jwqzVcgpLKToa
 q1r7IRRdl7+0uK0QW+ELWc+D7nGpw93w3wt4TrNiCiMFEunSb3MIPmAyHSrpbnimbvr+k+K6Rp1
 ynh3D9+TPXTmcwhOa33km8a6GaBWQo4n60lQiv4DzHeiNyOTFZgu6Gc0Ono0XNDtJzveJkldnJw
 1OaeEVZl/YZPbiWU/pSmf7HDlw3vGE1ar4W6nOWVzaCzslqjgQ9lIoqEF7LiNXPWeSXaxiRa8ba
 U7wYNClJerNZYPv3+yg==
X-Proofpoint-ORIG-GUID: iX3LzxQnfYxkgH-pWooq8pGTRD8xTs2t
X-Authority-Analysis: v=2.4 cv=YJ+SCBGx c=1 sm=1 tr=0 ts=69b12bd7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1LwNWVZHs5xAXWCdWcsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: iX3LzxQnfYxkgH-pWooq8pGTRD8xTs2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110073


On Tue, 10 Mar 2026 17:34:31 -0700, Rosen Penev wrote:
> Simplify allocation by using a flexible array member.
> 
> Use __counted_by for extra runtime analysis.
> 
> Shuffle some code as __counted_by requires the counting variable to be
> set right after allocation.
> 
> [...]

Applied, thanks!

[1/1] gpio: bcm-kona: remove kcalloc
      https://git.kernel.org/brgl/c/0258fe8721f541bbd3949cac2f4971b98e1fe4ed

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
