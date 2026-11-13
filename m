Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584848;
	b=3XppDQG72noeCSsQbajkQ6rE1NtkhpXQHHMPV18zMIJLUx7o7gCaaAVFEb5dh+xLYHxq
	 IDNiw/kQ8xOSWS2rUTk1G86LkbYFBXuiDXzxIFmDiw2CRgyJWVRGKIAD1QajSOgfvoWYr
	 fkxyGXEgtaz9S5Vck1PX0oMRgofIl+kPdXAF/wf3XYvx398gdLzMlY6bDnpuDdw0xgjfl
	 DYpQ+KEbRRiSFEUT0PUh648pvwPe68NsGXp7RXn/YoD8zwZAjygPTS/MLwhme4jZHuWpY
	 HxV7CJX6J5zs64Ez4Dk7/AgGVQz3UM+Y/rLp53RKDB+7QPtdPmb9inCWp3bFcP9/Wzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584848;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=h9BqSXf7g/loAE1yFy040EtHe/rxhdmlJ4V/zK4lUtY=;
	b=MwvrOr3gpf85VyZZcCjAv0SMKxIGUqA5B3l1+z05VrkImbeD/kthOQLaGtT1f1dK/Y3V
	 /L/kdI5UA9m7kw4lNB6myphrz334JWScI9LhX1VQQ3z8mL03OudQAz2l3bACMCo7na/Vv
	 Sfg8V1pndq5r4adE6bhXhovZ9+bl+1RaUaidqpVrrJbKbetMfmiSUH5jCcGQNebEckDs2
	 aiSbr0Hfdc0A/udqa6kAmjkG3j7rVIwSHbCsoWEt9qnwuv9SgsEfl53HLCwMzdaUbx6J6
	 w5sigyrdNN7uYMc6PghCMC9EZ3ceIYQStoygyzpnVUq/IOrtrTO29fdA3tKU2tiFAHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wj7NGM6l;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DCUIDhhX;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B560A5BC1
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 696B560A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wj7NGM6l;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DCUIDhhX
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRSSH3296067
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h9BqSXf7g/loAE1yFy040EtHe/rxhdmlJ4V/zK4lUtY=; b=Wj7NGM6l+Qf66YU9
	1Q3KBVqJOhJKdDvacN+5NCa87Z1uptSvFV6uuSUhtHwFDO6Et87Mnz9leStBgexs
	LVYGaEO9IcZYy6WFmR9t0s+2si2JpQ6hHcMBdVXvGcRozbOLvgXWo81G6EFQyEWh
	aFGgeSiRkG5/oTdhLkvobSbJp26ZziSr5husz0fHOrpe0QbNEtcH9iwTfarXO7nw
	XtEztMBr0G13UQxqVnCnB3Y4gIigQUgg3+SfZtwVHkSzayAN2FtaX1uOzghhZyFs
	MgX8CdqZ29G/fRjnWTi3qNA1XlJxdwbkAJ18CeI+zqoP0fuY83kqmO0ifRkr63EZ
	lskYqw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6t0pm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:27 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7d2deae0bbcso167578137.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 07:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584847; x=1795189647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9BqSXf7g/loAE1yFy040EtHe/rxhdmlJ4V/zK4lUtY=;
        b=DCUIDhhXMTyQ74WsPSCshiMm68zo0LpBpZjVYBD5bpfIlx83zmjK51N9gRfC97yap4
         LOBFDDVu4iWeSGU/75OyQcPcV3+7YTc0krMIV8NdPwveD3sT3NMHD3qtsKNcPTKgqMtb
         bZkiHjEZQFeZcgeKTro2iLh421b7sQj2kIGbYKw/+gQvb3MWOXLusoMnpNy1wdjHC+dZ
         Xs5KUcsgmtMDbE3EEquSlVKM1+AKBRYJLb6PQHGKfTFeYv86HPFO75JMC7xAf6yfbJaF
         6SsbMXyKbeSsaLf8gCvZ4mpc67rFvnP8b7XVRn+kjxA6BnCQUJC8J7zSNE0yBj/Apygm
         EbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584847; x=1795189647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9BqSXf7g/loAE1yFy040EtHe/rxhdmlJ4V/zK4lUtY=;
        b=ADaDt3cbhSmF5QsNlmN/zbEGpBMDfsbeFSTL2xkRduOhb/ib7IAVwKfNi7B9ZVEBKe
         vmxtvFQAW6KLIWjoHXJ+PLIZjFcSSSepYMaYgfxR28/ulazpMtnKwYMkKwIQNfnLTdwi
         iV9OwFYAxByskd4jIKvuWlHrTRVUwSoIspB1WVV+1hRYppTnk2g3/S+slPYvjNtlzvXy
         8GNHF6Kj2j82JBj6BEkomMY7Y3x7ed6k1uA92cL0W/0LoNin1BZgMK4KZaMKcsS8OEby
         kspfxYsUYTp4hWD3g9wES+z2eHHU6w3azEOQJzp418Xc7bUvOujt/KiLuG/gvV+oeZHr
         Vo/Q==
X-Forwarded-Encrypted: i=1; AL+hErGHv9u6MKMzTCUa8dlTuqxFxoCIPJoa27bjGvuFPdMvrQVUDS8dFELw8OAKFv1YRLEk51R6qIBuTHbm09WRlF4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oBIOvcDNCBBkswhRZNMFW6lbhLkut76hie/v2VqU0AETL2PmW
	yGePEhxLocmzVwIylOkx7ysZfmVqBWa4WPK3n6ikwT1/vGoQtw2tTbyFcJJlXeH4Pz2FvBlYikH
	eGxkqwbn84pCROU5CDmJfUlv7pf2/kNqhwKeeKF49LP9yO9NKqF+t6VwgLUdkMMWdC1gu4mE=
X-Gm-Gg: AYBFou0ZHpH3Sz9SI7uDJyu0nTovz8SS+VwcNeVIhPJhjt5wCC8Zh5ocagzFHtErnYY
	NW1YPUnI6EgA8t3EUJpNumOYUlPtz20vAZERsEqUbgtmexPQtpA9Qmg40XGaV1oOnk3R/TSToZ3
	zH9fOqEoO23qWr0MLlRMGipXW/sPZvIITXwgoVBJPM7C29YmBJ8HHzbYvWr3zLYwu4+Ek4g7HSg
	JGEx9nLPjmj2WqIxVbVguK56PLhoDeTLWmZO889D0ciJFRtEQ7MQPpREvtb1Cg/rG/BedwdNjiG
	9z1vYup/xGcIt05VwYfjWrW6PujoFa/FxeDCfubyo0OnlHOU0f4bi8FROyN492xLTFf77s2eGSe
	TKr3yQRMkKisIlN8tOEnzLRPnYUo5n8MwI1PD6ho4olbbOn1JOLcg6UQUoTtNdrVI+nmt/uyFnL
	b0Ig==
X-Received: by 2002:a05:6102:818a:10b0:7d6:56d3:f179 with SMTP id ada2fe7eead31-7d656d3f6b6mr438724137.5.1794584846898;
        Fri, 13 Nov 2026 07:47:26 -0800 (PST)
X-Received: by 2002:a05:6102:818a:10b0:7d6:56d3:f179 with SMTP id ada2fe7eead31-7d656d3f6b6mr438690137.5.1794584846353;
        Fri, 13 Nov 2026 07:47:26 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:25 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:47:09 +0100
Subject: [PATCH v2 09/10] gpio: shared: removed unused field from struct
 gpio_shared_entry
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
Message-Id: <20261113-fwnode-for-each-prop-v2-9-4edc23d5cf50@oss.qualcomm.com>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
In-Reply-To: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
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
        Linus Walleij <linusw@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=i7zxMYAqFJUyBEqlPaHykWLWPCM6j49xHF61fQqcpus=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD4bbsGTYuR8B/fRFJSRBUVofe0VmHcgz9pU
 v0FuTOm/3OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw+AAKCRAFnS7L/zaE
 wwLaD/9WxTlodVpdLurb93SMv5oTkU/VAxD6kKUIZOuZi/HfbDhtu4LmbA3Z4/7Luuintp/9wLs
 CTn9APhLzVDzgFuscV4tJNZqp+OuE9bSE1uiyUvm3+r70NDyDpSYB82dxdnqOAou3pyMLJMBtaL
 Vynofja76JRvf0UBpZUbTpMiOkx7L3rI35hXYrIAbMNnAlAJLDGOSWd2CTqBGPav/sVjSjGUBIl
 7qihCvOw45kdP3kX9FeLrDjYZ69Ro1c6lz/xXD/zQIi1UMAZVm1gnIPsNl1QfGKtyk8rJu5T4Tm
 oiJlqzTbBHlqLUA5YdVwBBT7AZ6l9fvHv6CIT6+6qiX2f/uUy6lo29Ymd4UdxNJtkBFR8JlWTvs
 UnHl4u39eSU4I+8cv/EfLURPd7+3Pkxxa3BdFWMhMtLR3gxz9BCk8Ek/2gkdtiTDc7vrw54zjM8
 YyxA9YWiUiTYpgjkpcXipszOHO7wm8VNqLAGY8/kwHdGwG+FaGT4Ip/nQ+VM4XeiDhys9IotMlq
 lSn1fSkjMCzffyo3cpjWwATrJlx9xiYHPaJcFw+LvpOf0I6Mj9Hhd0fcoufJnisday+AoBcRHnY
 lnCWjmnXBcsEIs5gC1q2MtPR7Ii+g3Xu6xenhGuYeE/H5mHefQwJ8OpII6KluZ2ku4hqbskeepR
 zau1tf3u1k1DAQQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX4aAIMunHetM+
 NJWBJNjjTDDsq6u//NAubtXXWA7sLSRAm3aSXLJ8VmVNTxudkYtpDAELvgpJ1oq/+jPollVGVqr
 wKCjguUENvUJJ7pgwynT11FwT9/LU0HiZwljn6t0tEnjRhR1rPi6lc+vHShrUeSS9Tyj9Fszi5S
 Ff295Q2GEf/OLUeWSkIzTEhitMyhV6kEGjOpUCAzlkph0VWGw/q+okILlZBXah9aHdcv57FGm6o
 UnAd+3Z7zaJVyRMiTnkpIVvt8gJa8AAzTBMePtq0BGBSjRtVCy8fjAnL2bvVOgqoPanX0HAlLF0
 WYeekbBgOfcdmEN+7srsUQMYFjWLzRXhpP4Dc4sPTsrC2dOemAuKk3DTZyTwvLNzH9TYXWFUzS0
 jul+HZeQ5tViclcPozPr6s8GphtNOdN/SkBiIa3XZbYMHAZkKZzHmRslJk8LJcuT9cuYAwjmjzv
 9UipIvcDnWy6yC36RlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX6nLrUdsEhoxt
 RJYfUlQ9nX4Mq6ukpzEiB8nUcYKrCYGF/w34JOWrUFQK3or4+9TlQvPDuRTfg89QY9LgKhsudlJ
 PyPUDtbAsZYg7R0ofn0/PLTXIAzy8OY=
X-Proofpoint-GUID: IJ8wKuGszciplM_4XYIpI3MNl8vsRYsv
X-Proofpoint-ORIG-GUID: IJ8wKuGszciplM_4XYIpI3MNl8vsRYsv
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af7310f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=RTVOz5xmJnInBJjvJB4A:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130062

The index field in struct gpio_shared_entry is an unused leftover.
Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-shared.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index edb04a5bb987e12faf96e5b70198a9fabf60ad0a..44af3bc1494e47310973844a0ef19ac3ec5cd719 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -51,8 +51,6 @@ struct gpio_shared_entry {
 	struct fwnode_handle *fwnode;
 	/* Hardware offset of the GPIO within its chip. */
 	unsigned int offset;
-	/* Index in the property value array. */
-	size_t index;
 	/* Synchronizes the modification of shared_desc and offset. */
 	struct mutex lock;
 	struct gpio_shared_desc *shared_desc;
@@ -233,7 +231,6 @@ static int gpio_shared_of_traverse(struct device_node *curr)
 
 				entry->fwnode = fwnode_handle_get(fwnode);
 				entry->offset = offset;
-				entry->index = count;
 				INIT_LIST_HEAD(&entry->refs);
 				mutex_init(&entry->lock);
 

-- 
2.47.3

