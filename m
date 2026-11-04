Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801051;
	b=lyeKa6KXNUaEWNzK7yBALtvpa/9m4MIQNyylbLwvwwz1Hw4tLNNmjcqY5Q2HqIOmxDRO
	 z7mhOdZPKWneAoefo3NUjKlR5yNMz1KVoO5cKfxncGz0+VS91fV//SJ7BOiVrSDGNp14o
	 LFjbTUvyNNkuBCnWf8or51EYkattGdvyz3iytWwl2pFbjLGfvNni+QWIJWwR9OpMVKgTe
	 FnTh9Ea2lwXMDyGpVc8FGqq+9LmrHuWFcWk0JwD8WlFNWvFt8BXXWnbriIoaDR3iqdS5f
	 D1a3bsMBQdgnx8KQZnU0FfsOZRaaN+o3WuFUMa+eip+rZOXKlKMsBw4mTt0AieoVD6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801051;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qrkh36gwGx93R5sU14vg6GOc2oh+UNDuUKbm1kAlsEY=;
	b=nPX6AbadgIfEKw3J+/u8VtDNcaB3ZznAOPqBhnHX8Ty/YsFc5u/ZC9OHLfMjAyEzlJdY
	 Jgbq7QZpP468xzzLzTMPz1+9/QQkynZo72VCVuQlzirKR6FI3eWA0EY83ZMpYtCS6ET9C
	 U2jJFxzjNpWiMsQymhhfkCmdSuTWh8xkGB+BVaioTutHzPeI3GU0zEvJKDY1LlGCeBCnX
	 4OwLZsJ+JwFb8tek0vtsTfF0eMTokDQOgROJeiNNcAUp3sETnnhZ+ACSLBg1wmFh7NjXW
	 5tR/PqyhdnY4uFwTYEd+Xx45xWEv5BxjhZf8E3lcRAuw4uKsV368g/iyqllrepnNm5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hUrJSP0M;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TH+gPYn3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2565606D80C
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 14:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2565606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hUrJSP0M;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TH+gPYn3
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BaHFl2729115
	for <linux-hardening@vger.kernel.org>; Wed, 4 Nov 2026 14:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qrkh36gwGx93R5sU14vg6GOc2oh+UNDuUKbm1kAlsEY=; b=hUrJSP0Mt8gOwM89
	5KbD6f1dJANQXZnFSR2CcGYiV3U7yoRkZhd1NTf0ix8a+F5TXzpgjSDBq7yCUqw0
	GAMse+xcJdgSfPtL4CqWLceUFzTW48Gegyvj9VZJRBu4eWz8QZHrny9HV/AARVZC
	Jdqzp+ya2b2KmUaiZhPm9RNgccFgI/9QAqZS0YvuOif9nxZJUP4zw9niVCspry4X
	eQAQaird7ZE8wsa2OhzgUH8gslTW/92WrZBgUo9M8l3CpI60Hw6l/yrplW4KL/M+
	2O2K0vYLXBkErIh1/qG/G/z8MJ94F4n4n+hBxyqV0imU1U24j/nT+CyLmbc2tE61
	cyQWEA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuvbpgh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 14:04:10 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eaab6fa0f0so681080e0c.3
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 06:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801049; x=1794405849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrkh36gwGx93R5sU14vg6GOc2oh+UNDuUKbm1kAlsEY=;
        b=TH+gPYn39HTVeHEBvKfIFgktoz5xnOexU4GXz67Sc8Reh6CpompYlkMNg0dspiZU5A
         MyzgJ3xsqEIepUOcfvuK0e7k9fzluUauUdUGNI32bc+kvk6V8l2KDEccr3tqaUyHvvio
         YuXHnJdszwu0FL3+qv8+tjLRlqyuKuBtfRGNu6zbGb9GStA08eb26bTSA4zLGEAUbn0y
         vW8xjvw6oSLmqJrujZOx+VOmPpti5QPnpshM/BmK3DMWV9u7sXL9OUSvoWUwuoRYFc9f
         /pl4mPyAw9mmElCBpnv9IQop2sjEp9Pucwo8fjww2O8jTBJXVtBozMeNRTlfjQdu9ubi
         yG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801049; x=1794405849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrkh36gwGx93R5sU14vg6GOc2oh+UNDuUKbm1kAlsEY=;
        b=0Y+5lYinychXxzgKc64EUhFVTPOp2zSF7zbzAyVBtQnE5E8cy3SeiDyMzRUiZb5E8K
         6Do4vhMndXGToMeZ1TqAiJCkI3CZEfIItXMgO4TvRGf2Ot3nZvAMZLRm4HrKN4Cw4jeb
         XQhNyBLiOszRR8gX6jcbU0B2tcvQ0GkITS5G5amKIkPcZpaMgVzUoqaa55PBMdMJgV1f
         dQpLu0pkItFBRg7SORNFH7RziQFDO4nYjttSmDGIn77V97hRCFFUKMLAY/eZv02GP89F
         gVszND+7VXmBOokxx41T7EOHtPiJqxvIGHDC0Rq0UjspX43q0OAVVI1tHXh5MpO7pW0G
         CUcw==
X-Forwarded-Encrypted: i=1; AKwUvBwsi78SUpKxNhx0ua12AIlh3vSSIXfI7+gMe42Nz+6u2h1xzzJNuJat4jS+F9VzOnXf7+7YaXJ8KL5UzafDyYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x3O/T2Kl6nLu+L6GRzgoA901N3ATfN52Dfrznr4BkqyAi8UJD
	V7fZmKX/0szMQgJnU2dcdNpVu/zFcTDPDkMgtt6mLkvjySIbUnctifbcJj3jjamXKUwTlSvIed0
	o82oNglL1a6tsj1EgNDzNdx7SnOOZLpAakvxSi7mHyGdakOXJyV1TY9usU9dL9AKKhsylD/A=
X-Gm-Gg: AYBFou3/sFsFrf2cu80ESM2kwpb+4WR7/fHSLh4hS0ixBmU6QspIluvPmkc96ogF2ae
	kcpgERCiojJHmT+ZX7BEbD/cuyi15ANIhU9XdXZO5cvIdWj0fr8WJl65D/R63ptVa2XN2sN7QhG
	nRA8C/OCvagW/HP1O499JEorE4ypAk/jYYwAfry9QLidIUsp/PIT3SB3rAmK+/O3vM7HbYrJaQa
	OncAEiWKZtJj8Wza+E9o7JeiI6zIg1cLwb5yTHwRsbkbR29/5XMymyW7zG9yM6RlVIqr890H3a+
	WQjr8YbasC6bBXi2CtkuGbLL4GkWGsA7kuX/1Qe9k9ZTO1zkheOpUySEhFk8zFLdO5n7VT/GXlL
	iR/Qee4SJmXlzwA8gtx9T2vSXzu1BG2tR3sjOl9Kia/WR7a/3dHe28l3PWUuHdwDqJ7k2g4Zhy8
	7Lng==
X-Received: by 2002:a05:6122:6081:b0:5ea:c6c8:7985 with SMTP id 71dfb90a1353d-5ec6851faaamr7134466e0c.3.1793801048570;
        Wed, 04 Nov 2026 06:04:08 -0800 (PST)
X-Received: by 2002:a05:6122:6081:b0:5ea:c6c8:7985 with SMTP id 71dfb90a1353d-5ec6851faaamr7134392e0c.3.1793801047851;
        Wed, 04 Nov 2026 06:04:07 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:06 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:43 +0100
Subject: [PATCH 1/9] device property: fix fwnode_name_eq() for empty node
 names
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
In-Reply-To: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=R5+4YFOhCFZOKo/xPA+jYi8jqwmw0oVnYVkmsrZp3qo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztR2VZRR8SSzbH/fsbXq5OEdxvsguiNVfCLx
 Ww5wWSa7BCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UQAKCRAFnS7L/zaE
 w5PBD/980NX1kpJDXHWY0ehLFm7ONkPKAuH/9fpNf1NS3nxrcWUQisefHOE7Rtk/myleJL9pvTZ
 YMTEJgUAddIze2s4CfeWGuQ8XZFF7XDUVZUbEbOtrLh48sNh7UZGAGdmdk0hiu2lX4cpQgRYCSK
 uW+Wi36cN5USM/zBa6uHoUVU16ijpbYdu/5buK2ZDpIuGVch9S4Cdi3QYTY4GuX5TTABbhDhMFv
 7DEAV9ZrMrQ7dAL2gqjtxufFE2m9E4dVq/OPbCMJd4uGCAFlbesp6DVR74ibKRP8u3vU2ZR0Y5p
 9IoMSuYhDCzsg34QdjJIKo6DlnCAH69Bv8z8luC+IjDAhxjCkB/BiSaU5R9/mq+7N+8UjeaIhqA
 GBwQmXvGVSyPqZkUseXbxJRz1zqT44o2PPn4T3Yac1vkXS0a2/FttiXRtpq0Yeuavow36rpt+Y5
 6/jgqc5sChJIQi1fUCFZZZtM45m46b9Zg9iVvaHk5deuUjR8W9Mrepc5mmFJKzrcaiPf0uy/cDO
 K157bZ32oblK2TKDNhw3Vsw3q/WsJ0zudQpSEB5tTuopcYARa1H0I7e/v/UnvXs8HYQ2tMzx9k0
 aT+SQXgewV42y6g5n3wfSwcX2GBztUDAy2y5NR7b3xRzlyDSGDM6IpzefrlsoUKH4riVfSSPn1q
 dT7ZIUbHUkPawWQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aeb3b5a cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=bz9ZealoQtrIp7hKp04A:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: frtdIe9BE6uqGCfsnu36zpujyVU3dTb_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX/f5FNuqdjqsY
 CL88e5yyS1CJegNmoHwQulk/XyDzcfdO9Idal+62c1MUUaIp1DDWXwBtnQcZmPwB+sxD+5SqzaI
 gXbAdU628HTuukveiuZPhPlwtXsy6mc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX1UktIJixXcVX
 nZdih0Lc6qfgQ93DcPqyGoyFetvLqq93BWAM1baho/Elwx31j9BcoKMsUNHrWH7kdb8/ZAG99DP
 MxsZe36sApLRaXorXLKclcXoUd9xLeEgwe5hcx8v8FXqLyGY3FWuou2xH6cs0OHfhPDU1KYI59y
 PDDteRnnI9VZg9tcJbBterR0AJQSwCi6TSU4mB/N4S68+0NqSFvah6EWBpu/qEDxiLvYkQlAHAQ
 8+ndfFrSYLG9I0mQFd/1kBi0Y+eW4/6IGnA5kHdnifiTqdgfDUrypW611Xp3h3zXb4iFgMlzd5+
 /O6CQJ/HaEBWaY8K2VCkkGlepzv/DYbknpkk+mDiIxuWSOe5I+Aq/uWCNNMvR6fsAzbpVfGQI+N
 CwWA0Pbwlh5BanL37CmmsWNqjW9MJyKyyhiMOcCo0p/1zyri9wR/xBrllPBdZyd5bQKIt0XmJxp
 jf6EjRHxIJDAz5vhrMg==
X-Proofpoint-GUID: frtdIe9BE6uqGCfsnu36zpujyVU3dTb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040055

str_has_prefix() returns the prefix length on match and 0 on mismatch,
so the mistmatch case can't be told from "empty prefix matched an empty
string". For instance: the OF root node's name as returned by
fwnode_get_name() is "" and will return 0 for any name matched against
it and since len is 0 too, fwnode_name_eq() will return true.

Do what OF code already does in of_node_name_eq(): check if the length
of the expected name matches the length of the actual node name before
comparing it.

Fixes: a9c8c738066b ("device property: Add fwnode_name_eq()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 51109794d7275ddaf4571584d0e77d8573ebb475..a97575ff9199004b4f401f432aed6c95e40d0c25 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -700,7 +700,7 @@ bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name)
 
 	len = strchrnul(node_name, '@') - node_name;
 
-	return str_has_prefix(node_name, name) == len;
+	return len == strlen(name) && !strncmp(node_name, name, len);
 }
 EXPORT_SYMBOL_GPL(fwnode_name_eq);
 

-- 
2.47.3

