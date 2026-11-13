Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584835;
	b=TtWsqVYndTOc6YSR552sqQtEVLxeWflRezyrt8oyNmA+le0NybUXfAtiaeoQw85d9UsU
	 lzy8TmpF4Ia6kUbMmgmeb2mQ2wlS1t2gwlQOjH7PgT7KZ/hybf6imZ+YKxqvfb9024ehs
	 qJGmIDpTN0J50vr4K8Z6BjTT77PbQdxnyG5ugU6Fr24i0vi0UN6weTZmTZ06OAbMigagc
	 BRJwIK2hA/OF4LxDagH1KZTmhbCvHuU/oN2wEjBgLtFWZpS1wiybvw/6Gta3jTXZCLsQp
	 BNd+eA3dDRzrqlIYKeVFkZcwot0prYoJIw8oo1/SaMsNIoVWqmigt3iiWB3IbP24wNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584835;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
	b=MQp2SEdeieuJZJoAI2L+fmX2FJbLfFRj90TKki8q62CzCJ1ngIvaVtof7lxD0SWHJdsk
	 /795fSzU6EBr6HN6ZAgKRyoT5BI+rxzv9Vl7+7/f2gNeBLtpqX9vqCA6rK8ml1Otcprz2
	 8JJpZjUbKdfoAo4AN6bHwpaYyv1Dcu/vw8uPtvI2UDLQrpCRzVdyQEpjxRdLbfGIVL6Ox
	 JS9afh5kUifIZI7+Q1LGIlZeOjME6zBzqV8YiOUe5I+hf5gUtFxkHmznV2/WfPLvCJso7
	 YPXnbIbknd7lNoIi8Ki16/FIl7Id4scw/WPkNo/ucWgDDmBcAB45aiJ7Kj5rlSLc7Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ayi6Eg+O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H25Q8O25;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4B606A8A9
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DD4B606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ayi6Eg+O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H25Q8O25
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRA6T3618616
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=; b=ayi6Eg+O63IiTBLO
	aqwR1MzJcaQbQY+c3boQA+MX5zk2g6EET6JG3rVQX8Woz0bMlHrl5OM9GU6w71aa
	+/dZsWCbKNphMNNbckUtmF7riqhc2Y+jOnlFRS+OzZktvQRCKbh3ADhAuypPOKaC
	BVxLJUscjeaSjGGSNgZj9ts7Lx/8oA9Hks3saOq/BdDFn0b8IQ1mIzL71o4H8Aha
	k0aE5YOmIO2oJP/y+d0IQe19Twc4Vs0z4EMgX00Z4yvFTYQ3lOvCreIDzt/OM4gw
	xVGS4wMHGm0SGrMJMAXdZJjwJ+uInlv42CT/5THt2xc8OWUVFTKbrnRf1K55YaiB
	D33sGg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bcpt5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-944101e6367so201265585a.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584834; x=1795189634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
        b=H25Q8O258Gtu9tPQnl785AIBqPlebbC+4+2PjuOZ4AcRn1TN2x2mD23GADMsB0yrwR
         KBTDy/foJsKvjp2YgQADeGQghCENyGqtjzATRhgQtA/6Zu/NtEMkNchEqse1MUrfZF4g
         XcoBlYQjHFYiLYCRU05jmR4PUtsVuv4O/gULM54kQNcAPbxObeWMlbXszhRMj7fHOoli
         3Nh/1d0SG4R9yI33cJKlN6nezmrur4+enxKYkZ3mBaXTx1e1gAjdkcS4vAzhs9vhDKMu
         XbQu+Aov5V0LpWltdzFjFPu8kibqaqnIv4/+czdf+K4BwHaXP0K++L9dBkr3yiefXys/
         urXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584834; x=1795189634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
        b=TydvyKIoeblzUFa7dHb5S2Ydfq95VKwspHy3MIOXCg0qi6PQV1GKQ2xHfIFwiwJ4kH
         Ws63/uFrc/a3DsEYqPpvntmpwXaU245ITW0O4wJBhnb6+7LyoDHuGHtuNaHwijZl7pBP
         k9YytomxjwtT8zdEPfZvdb2rpI1Ts0iKOaIROCUXA40jMa0v/d8dk0+aJXV3zROQ6bLk
         GzFOCiLfrsBfVZwa8FcKCu5T6n0H3pjJFfILuSd4D6LbZPyOrZsFqItmdzSOoCVW62PZ
         liOs8aGke5NZ95ZrsZDzLVagKa7/yM/h9CIOtsapGRiIClU7p6R1DrM5/jw6lYuhlUX/
         GeKQ==
X-Forwarded-Encrypted: i=1; AL+hErFl8cpYPIa/fLV+W3Fo156jiscuMX2do+xHxKK77lmkUxwW2LjPFyQastkIl8cBdZ3HKNCt4ichpt4C9Qc7Hvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Leu2w52KyBc7aBKlrvXh/f0b/TWxYznUvrVU+vJG8N5MFHQPR
	giItKBCqpj08H9SrJdyBp0zJWGn3udZi50LCHxb4W8tect2nFDrRhY1edtgnjo+at//RVoNsbY6
	kGKKNFuZo+IcGonburIUxhT6vcA9xG92CBBfJgwhg7sW/oSysDS73aVx/Y7gGmZ81mz4RREM=
X-Gm-Gg: AYBFou0dfcGTL4h6JdB9GDWf1VsR/2w5yDmTGGExJfQxIye4TGy2wqK97TLrYyeqK7V
	TQXnTeEUY7BtxSQLsKtf/wQVvcXRbR/vKV9i3I9/+sP8QmRtQOw52N4t+1nHMOeoF0rE03oJRRV
	vytOjaDAxcVuYW6P856MW6u1DRCiEcFFv6NjFi5lhGC6uQ/DRnh0LmcKvVnp5EAHVosZbcfHVFT
	KlkCg/tUro4x68Gp9Y02oeH9eygArqRzYh+e7q79SBQfKGC2xwM8KqDqPhz5hhgLbRfyjBTqir4
	EpEPL1Z8Ji7jo1cJHnXYqXAHZyjnkh/7Xk15Nz2BidRq3Xeiju9cPeaLaw1q/9MvV2nye/71cji
	B0rf+rABrEEPlnszXfa+5JY9rRdy7qof3kaeBYqIeAnA4ZlyuiEAEbOVy76dTU+Z8QKwe5Hqfl/
	dRLw==
X-Received: by 2002:a05:620a:470d:b0:93c:3863:ff7f with SMTP id af79cd13be357-94932adc85fmr983714985a.0.1794584833630;
        Fri, 13 Nov 2026 07:47:13 -0800 (PST)
X-Received: by 2002:a05:620a:470d:b0:93c:3863:ff7f with SMTP id af79cd13be357-94932adc85fmr983709185a.0.1794584832967;
        Fri, 13 Nov 2026 07:47:12 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:12 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:47:03 +0100
Subject: [PATCH v2 03/10] fwnode: define the property_get_names() operation
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
Message-Id: <20261113-fwnode-for-each-prop-v2-3-4edc23d5cf50@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=vlyXEW90tuaHwDARKd4JGB2+R0K81QD4UYSlZBasTXQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD3CCYRkoz3LSF5VgDezGuy7MTYSM/0TdLmX
 qVEWgNL346JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw9wAKCRAFnS7L/zaE
 w1UjD/0V570v+6T5CVF4PFoZpn9KSq17LrtfokidpFBT7RDjt0GRYJmyKILIOlVrVDojHSNz5IE
 ALF8BoTy6aoU6ezLy4spqH3OC2kZzdtzaAg2dkBDAsHLjeXT5/QA+l6C9Jtre2CDtyAV/2TZfu3
 vVClJn4JVhPMDmaHAFWQsvSEODTOv6nFe8kuJ+xlmjRkoJcmKxzO58MIdNod6070QXKsdAOj4Pp
 J1WlcbOE7ohJPbiImQO4upzTUygicE1gmchdSj4okHIh5n53012m5vpVLKBCRweFnbUpLzhu9Pe
 jQF9QzJw8Z0s9DMHUZg6D6jxI/i79YzJJ6KPK0LgGs43jQAFIg+e/GaN6z5hWcSVco+n0f/sWYg
 2r22Fsz9+qknrFCJ0ioxrQicw78BXXeOLMQsNOATM9G3cHzy4Nxoe//20p+12c+vEyLva04Z1wU
 l1n5RtZVdhGgO+6zL/L7aE5IO8ZG7mIV1aXSJ+JkbWyn6K9szQrV49Z3K2TNAfCLEQEWt4xlFou
 L5kKlZY8oi7mWvpB0XVeXi7qo18prewpNF8k8AyEit5hNe8OZkyWLdENpHK+kiJZ8WYoBWyaAh0
 ikNTb9r9ZSTfZLatbOnya7dMYksWgzSjJ/3zgN/YiAF19+LkWm9T5CqXHtHmOeWZ3fWSZOyd0Bc
 UU0maWv1yZ+Xrfw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af73102 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=jHVjgif8OWDE08c-SeEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: yHLFbVtfBWms9_Gfvjmp5QFSu9eOM8GR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX1KvIL0R5ucx8
 Jfjnpi/x3FzjfcAbroj6BwTlfLtp4DxVZ9qdgu/U9WTR4QYcKvOIrmD5Ikx+/y0dE6vR8SvtGr1
 4JrA34HdHMUg7lQN0Knle1UO7z4SLlH6fSAdKZmPXvmQUJ8Tn7mUH21XdGoN+1iT9D4YOn29fI3
 Ee59u4+jpdT+4KHmDdO/xz5dOtnOb7sqAUK0B8O26meNRV9/pAARoWCGrux1FuBUyglNbfaNulc
 zxrcjEjorK2MzbPYe9KO4OvJ5/tQMBGg0SuAwBo2nQs5MehY1x4zxGnAp0zlXyJbmXVDe/51fLl
 h0bP/Hv8hfZiPxP+iwytnkCDNsE+BKmbQDJWyFfnL5lmw+zn1+CMto/i/fjl75swyTSStPLip+W
 oTJRfPaiker85B6jdnjhoOpDRkNBl/lDXmmJj5N2yPrJZ/WOfbyR/3r4coy9dLp3aYs9z15QyMb
 w/wxJjjkPB7rUBMX/rQ==
X-Proofpoint-ORIG-GUID: yHLFbVtfBWms9_Gfvjmp5QFSu9eOM8GR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX6iPSTQBpD5ZE
 VGQQTJAArEUrU2YkVPLuaBI1zOdr5dMGc5i9xfVQWqSooXjsqAbBWgt8jKWVYNGXQk8tDBcenH4
 3Npc6FcSAl1CJ2zNt9+baa9mMX0yCQY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130062

Define a new fwnode operation allowing to retrieve the list of all
properties of given firmware node in a dynamically allocated array of
strings.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/fwnode.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index a9dcaf7e70765637a0c33af2ae0ac541e15752ad..2d7e0b9245d445d473c7317bd27058abe5750b40 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -125,6 +125,13 @@ struct fwnode_reference_args {
  *			     success, a negative error code otherwise.
  * @property_read_string_array: Read an array of string properties. Return zero
  *				on success, a negative error code otherwise.
+ * @property_get_names: Retrieve the list of all properties of this firmware
+ *			node. On success: returns the number of properties and
+ *			sets *props to an array of NULL-terminated strings that
+ *			must be freed by the user with kfree_strarray(). If
+ *			there are no properties, 0 is returned and the props
+ *			pointer is not changed. Returns negative error number on
+ *			failure.
  * @get_name: Return the name of an fwnode.
  * @get_name_prefix: Get a prefix for a node (for printing purposes).
  * @get_parent: Return the parent of an fwnode.
@@ -162,6 +169,8 @@ struct fwnode_operations {
 	(*property_read_string_array)(const struct fwnode_handle *fwnode_handle,
 				      const char *propname, const char **val,
 				      size_t nval);
+	int (*property_get_names)(const struct fwnode_handle *fwnode,
+				  char ***props);
 	const char *(*get_name)(const struct fwnode_handle *fwnode);
 	const char *(*get_name_prefix)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*get_parent)(const struct fwnode_handle *fwnode);

-- 
2.47.3

