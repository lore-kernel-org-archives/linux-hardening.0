Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801065;
	b=P3t9cBrf7am3ZW3u6AZEJv7A7RK+u5lYu9bi89eE/yl1j11J++w5uxL83K10PzUq0wXm
	 n7RiLTRTw4BhKR9mqrrGTir7taDgj6R4aI0Po0fc0LXPhvuXvxLf1igSP5r1fJZjIEdrM
	 zorvEglZr7wSGfNaxITvI6WTaHVKjZ0SVX4QQPNmNSchTiI6HDBGhOuVRIfvqd0vYF/+f
	 tL1x6fR9MO89Qb2+1SLo4xOMohaMSInW0xAAwqxqs0lrRkx4o9Gg0nIzMqvRlSA2lD8M2
	 Mj3er+3hdVgehNVOYg0OCGUIkOQ5ue5UjzGHNYIRvJqP4TIa5AzsA2mYP5Ku2TfIDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801065;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
	b=twLvDu5PkfpCXdmFFs5UjZna//An9S2KuD4NuGTPEarbbUS/1C4pNs+7F8VYi/WA7um1
	 xWZuKD7sy20s4aomrYTk1VvLyr4VpZAoq5+Z4KS/EnkBxNZPRfxXrBg6CPOuT6qthHXTX
	 AiEJWdydGzAIlN3GgtxmBc4355dqmaGfYIlY8AU0ZOMjYyJvsGUDe1BiN6WLZ1LFQSoQ0
	 8CVX9J/dgHjU93UZQMCWbO0Hkye68unkBzb949DMnrvVNSBLy8T7hOS04AvChZ4dgMnKZ
	 fc8ERhXb6yVOSRQyuDXAelyUWdKx9y2ZlW65g8qXw5HGNpXWIrCOnVpMRnuc9aTQiDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZyMWzQsB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lw7Ijwjw;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D457606A33E
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 14:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D457606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZyMWzQsB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lw7Ijwjw
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZxWg119409
	for <linux-hardening@vger.kernel.org>; Wed, 4 Nov 2026 14:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=; b=ZyMWzQsB8somTKQ4
	gMi3RoSQ0KBzQTZE959mdwa0DCr+eXsvWQEDJdWxLa7xLthPcip4E9US2RhNMUWO
	vPOamxpI7QvNV51/ZY8ZpCnK/10yZlknDsWdxAzy1J6UcIcgAivPuTHQK+lgPg5Q
	PhPIaSavgqP12V00C08tkIK3kBM7Td7NRc+pKl5bjpgs53iwESuA8GApOxK3Fo5f
	TH1Zqaglwa9JC2cChxqY4URyvZkKBs+gjb2u2M/2c/bNR5Gu5giyKwkGrAM3gRjt
	ZTWTtuVKqwXtUxboWAGuTMnYMAjgK7eApbNceCSHyq02GsYomazYmOBkFyUucd/H
	+4Az6Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb0aaqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 14:04:24 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ec3e1921ecso607202e0c.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 06:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801063; x=1794405863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
        b=Lw7IjwjwbyDdLL1zDhlipkDiIL4B1UIHTWQypEGAmDbK9yCIoLEjpiaOqAbE3+P45N
         GS9rbn0Z/RM0g0xwqWXSLXpSgEOeXE4yIRmHlsw+WHoVvebQaH/bvCNE2nUKizWRDuH/
         +A4SG/xIoHOjgOiuGFUqKcAPUTh8+iIXleMxBb+eKxO22KDrONLgWnh6/4FoSxuyFDEi
         oiaCiuZqb7dvoAEo/ydU7oH58XoMhAys/CtjdSrjKBfY7Q9XaslinORWC9XINlxKpfJm
         TDzm4LYbkeP7qzkZNJjkGrPiJqgZTSnV23XAvI0wc1GuPWui+MAxhHBco+0szR1hk6DA
         I6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801063; x=1794405863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
        b=d2iyxQRO5mT3VWYN/Uu3J5YJq+8IrUEoAUg/Psus0QFb33RL2Hnadu2IUPzwPJPZ8q
         gIUsrIxX6YxjJX6BHogkeUgW+F72/GWMFIsqqJv/XjoMdSEGcEPQcV5w8CohMlDKzklV
         2vqntio0+smXGd+oqYTLLmw1mQnfnSqhmalHbbYPkbWPscOvuAUhLsM9r8z4sc/Gz5bd
         lpN+a37S+nwCv2jEyJYyI7cbHgO3A0iOYQue4JK0uX5je/UHY+CMUrwzQMoUMUeyI8FY
         Sy9vYyxwE0z/Q339DjJ3rf9DOqTMT/Cl5ZaIqzNwjh6iQrT8g9+e/GNwJkgt9t1yenSL
         ROdg==
X-Forwarded-Encrypted: i=1; AKwUvBwqt0P7eHbsrrgdOzfa8okQNQK64sz2WUVRtzF8ICokh1OWtLOe5D9q/1QVRUzF5QipNPmgopuffVChJ+58EbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/R7OlpGozEmVHTpl9VzF3C39xFZu7Fsg1IrjJ7GCMbhVZENxbL
	vlb+jPe8z1w9JZWEJo2ywcNdvEN8lI4UeARM+krFyTaCM9E6P/AZrTTNlsfC+82/UP8b15u61KF
	mPZMdCvnV+XxJiILTSpkZRO0iUSU0+Llbj58ELOnCWU0TvQipVznah6kXNxQj4jgcrWXPmso=
X-Gm-Gg: AYBFou1s6GYZEdu/AJXiKlWg70iOtKd2/xP+UKJsq9DDlAtyosOONg5pKo9kEkswHQd
	XVzIqLQMAZEAmH4c9IRJyqWvPd74AR2Bdyvw1SuL4FAZhknikyMFxp8N+aJg4iaDNELq34VcUHZ
	4/9BH1NsXCuckR0CqWKpKtCsbvw9eHL0p2rHqdeiKhfwgP7sWjfy7ssIfxFXLtfALeFktPIhB3s
	0JFsDoeCQLHByGcNQexiPf0KQTg9ir7o8dEN0H97P5/eht7g6S+og/8pmjR/ypkmVz6zuimI6e1
	iW1t0Q0lwzlwUbupFbHQeZOX+qa4yaj8kV0L5Nnjtmkcv+kHkLmqDmG1oFuKJZ1zpbQqT3kMxoA
	c1CWyzOcYeSgrpqv0ltSRCme2jXtNCvJNA5NJLLobs9ho1URj3R7XGIDjovJNw+Q3ISao9R+rEf
	kbOg==
X-Received: by 2002:a05:6122:c155:b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ec5879d16dmr4306411e0c.15.1793801063208;
        Wed, 04 Nov 2026 06:04:23 -0800 (PST)
X-Received: by 2002:a05:6122:c155:b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ec5879d16dmr4306326e0c.15.1793801062468;
        Wed, 04 Nov 2026 06:04:22 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:17 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:45 +0100
Subject: [PATCH 3/9] fwnode: define the property_get_names() operation
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
Message-Id: <20261104-fwnode-for-each-prop-v1-3-6e28fe1c72c4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=vlyXEW90tuaHwDARKd4JGB2+R0K81QD4UYSlZBasTXQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztSRKXWWkliovY8qVo68abtoXtQZqXdDFLls
 EQ9sf+1SpqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UgAKCRAFnS7L/zaE
 w1S6D/0b5eyCDtTat976om/WwrrkmeCrdTpgbsGvagClks0LTeShFP9+nuPD7PIJzrL4/pyP4M6
 osTD1xtFE9oFRr/JKicYaJUhGNjvhq86+P4Nk0irweouqKLqlsQoiqolxRUCRRKWKX/JOFw5UPN
 HwY2EWjrvKNLBv9U6+Nifpym/U8hKQweflNnRfIXMu5yaCEGnzB13cNCoSr5HL1f//BkvCEHlv2
 OPsSAXEeenUZz0HAqp1+xs49AiwTwDocOsc2pYSH5fYgrlshGj4oIr539GC3P6v8XvTk5ciwE21
 8rqNr1cD+xfY0XRI7qsGlSTq5nHwIkmkZMmzCZvCFemTxiQ7z+VZ7fi+sKJOjXXDcDae7+6ti9f
 BKhxyuCoZ9ZUZEjD+bi6CaZy0KjDzBI7MkJ6QkbfHnxjI6f7HBgQw8Az4RIb47ydJsP4RSSktaT
 ycW44vOZJCTTGF0I8DXuOsC8RkSLV5XQYK9ZwB3eg2w1ZK2577lrjRb28GuXgAwUP0K9smBW2/S
 05FciAVt+9P1WzFmvql+IeSba0EOXnj6DpiZDE0L7EjBVvDlAxtiJTyKlAfGM9HaGAZtOew/agm
 7GEz4McYIbAFzg58gtwRtxBmmwapSdtihU3Aq16E+xr+ZxaM48Qkdrw6gtBtwvCisnZthkFavFb
 VxhzvSv/E7NtLnQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfXzSgOwvERMR02
 xJD0GP+vuxj+qhIWQOE/S4LPwTH4/RTaIQ5JaESdS8E5i+pdALwHWR0S/ds2m78+2dXau6cmUmC
 9BXp4Dz6it8LvZkSHm7nrnGf8z3U+Ac=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeb3b68 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=jHVjgif8OWDE08c-SeEA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: yYKwLd4bUZtwmisJ1EVRHcAcM3emFyRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfXzrZs3T4ayKc2
 rKYX852VVp3MJOw1/Y8IZsWgukzRrSDMg65wu4UxUVxENujbpyb/tnlAa6ohP8vZXaVzo7+qosA
 cK1I/xhqTES3YXkBeyVluSTB3Ya6bXQ7ZiOXPHVKygoM7gLoOrYljl01c0u8Ud5lUfMNGvnXiaJ
 tziQ3qO1EtMVyZ6WApRkNorV9jHNnOJROlLfgM8Wv+3A6zwelIkMR6OblO08qtdU74GErKDJ5vM
 Hyzd+fxs0O6cEatUi9OAB/tcnKW0FYlHQ7xjUVLZjmUneDPBoJNy9GMVYk+Y2u5F8Xc2Z+8Og07
 sptBrlqe+sJIqXep3YDrOsgWNOCoN+rrZr4pKEWd2Gowf7FnNTDRyUamdYNFzVBiM25nbCEAtd/
 g075ugEVqkh9WOg+mJkM0FJkYAMIraISAfyWIRZXX2GHVaqyUVtSzvt2xO2QYTJ8vLrU2/k7VQj
 ++qVe++o50AqaU0laXw==
X-Proofpoint-ORIG-GUID: yYKwLd4bUZtwmisJ1EVRHcAcM3emFyRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040055

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

