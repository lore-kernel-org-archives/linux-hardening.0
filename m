Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BF1487D6
	for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126110; cv=none; b=FFk093qZhCYpk3d7v8H253WOXzQEcy0PPjCLvJGiBvT6kYRTpZiqHJaDM8LA2WQP6ZNuBj2i1MsJIMzibWC0vp+Xl6iFCO3BDtYJR1pRGLFL1QQDArsj1xMV/5U9UFZsPJ6RVya9YQmN4wwhA+mOCTC6x4NNz+LTcJe1+BVahBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126110; c=relaxed/simple;
	bh=o729TUA+/3yrI2XpDVI6zjAuiCqtDa09o5cSkSVCI84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rnQ1rwin9ZHBSQ8FzJ3Ml2KrRRfHeqtCOGqTGyTWtZFPF9tKR90lS4iJbjs0rj7SnigR2VAIjZw40rgtMpX+xFgoj8dTO/az2Nuk0XQXFqs/G8WmpeZavtqxtGwMgQC8frezR1d5sxEDTey2E1m7RAAX/iwUmpJiPWiIMQ5s++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aAdeAofU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aAdeAofU"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e12dbc7843so1126069b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 15:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708126107; x=1708730907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXaXr91zE2iwkpuzNYcgIVZmRt4beRglHQkgu1Q6RzQ=;
        b=aAdeAofUkuGriETMEhZoVyVzihIClabjD93JxqPUpsCpx+cjIIwdjairmGGiP9XVog
         GKVQPfouu7Am3DMuQcvxv9NsuC4ryxtKsFeZnm1twN41IGuIn2THndk/4xq9tduhBoq/
         O53B+kIEOv8pcuFnqPogxIC5SMa6FpV7+YJVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708126107; x=1708730907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXaXr91zE2iwkpuzNYcgIVZmRt4beRglHQkgu1Q6RzQ=;
        b=b1tSa5jCBQ6L/SjNGxjxUKZxjCnK+lFpCCoEV835AjI1BMzI4EbcfjQs1rwspLv5cd
         iLfqfWbdcc/eVXfY5kNFv7WoqW8CS4koR2A87qgzKsj+bS3/g6lSWd3gaP94bM7MVKw3
         7ShnE2lR9U/850kRLr4XxH5uMKOO1zoIXuokG5l574/SQNj1UJGMfua323GuXFYZUP7+
         nUEDKN85MrNfCIDvlAtjjjR44z9xNVy15jSlghrfpizeYYrS90G4yoI19kkgM3hXIi+V
         3CHZKM07m7tT6D9KusrDfievGgnlBWfWfHavjZRmUI5ijrS+jtx/hIis+KNpx6yW7+cq
         bT5g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7PKFsbf5wXd4O6vDCLWb7VkH1GQk9eW4aWqlFxFyCmQBiUkN6gH9ILUcDisfJ2W/03FdTbNZgJymP3J7xvbSij4BoPIvhQRusZMDzDAj
X-Gm-Message-State: AOJu0YzvFmvjJHiVgdKePlUTTYB4qNDlcd2GJ73jkXc95xBjoyde+2y2
	BQI1WkwILPbcv1gktOFdzLnRfF4ovlm+CZP+HBJqaKAD+1nl0BckR8bwHpFJ3Q==
X-Google-Smtp-Source: AGHT+IHzmse8nnYR28KfPJrToxw6+BFDoqXkfVQ5zblzLbp8e/RsNZ3dw5J5POgI/1Eaua4oIaLVrg==
X-Received: by 2002:aa7:9887:0:b0:6dd:88a8:cf25 with SMTP id r7-20020aa79887000000b006dd88a8cf25mr5714710pfl.8.1708126106847;
        Fri, 16 Feb 2024 15:28:26 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bm16-20020a056a00321000b006e0d22fe8e3sm476961pfb.116.2024.02.16.15.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:28:26 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Viresh Kumar <vireshk@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] greybus: Avoid fake flexible array for response data
Date: Fri, 16 Feb 2024 15:28:24 -0800
Message-Id: <20240216232824.work.862-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4687; i=keescook@chromium.org;
 h=from:subject:message-id; bh=o729TUA+/3yrI2XpDVI6zjAuiCqtDa09o5cSkSVCI84=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz++YdWhS9IIogaVrW9SXyH69n7HtxXWgzsEWI
 xIH+eLcTAWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/vmAAKCRCJcvTf3G3A
 JlTnD/4zwXwfUJWeKhGf1W4ft6eKbqeQCvVoNZQ9aKFDD0mrJwYRLvv3lE+NCFt2OV8fURFxPPm
 Zi0XIMgEjr6RCcAkWLMXn5WFQlCa7kl3VPK/mcTEY67RfFtM7yqKxQMCg93xlys0g6vfyvbwJD7
 tqiFLue/hRz/hoNvDTY1eNL/ssnp5+c9veBSEChT22FCQUhmrTh82/qH/oGTvts4/OqsET1papu
 ZaDE7QFWM8Gufc850aQKbdha9QGlsSkYN/isMz2o7dL88+015HmuZ2iAXUwqVAEvKWrKP/++Z1D
 MAfLPX9mUdUbMRrS4KSc07keJIyT8pldu3A4LofOHpNF+GQ0tVEs04seMyOBsFW9R3oyQGzAQQi
 Na55cRYAHTRU+wfJrcR/7KL6pLFiXzMxcuWvvR88O+aNjlK9TH4JqHBLTMWMY6144L+ajxsWkMO
 FrHOp7mImhRmyEktzBG2fXS17A4s5BXYsOiNTkxQzHGii7vcjNetNx3O9ue8LJU/2D5HLDllPf9
 c+UJODNrmtCD+6/4n2+w0QBLyzl9tHN3WdQPmBF8WkVgBoZvqQFqagKjKqFlqlSoh9S9k1WyD+a
 EEjjdpdCFOv8uxyFFZiBAhHhZ7Kx6U6WbXwQnOMJGn0pP/PsczRro7m59EI3yT88cICN6/FK+Uj
 X0M/NCL XdMlbTTQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
code base has been converted to flexible arrays. In order to enforce
the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
destinations need to be handled. Instead of converting an empty struct
into using a flexible array, just directly use a pointer without any
additional indirection. Remove struct gb_bootrom_get_firmware_response
and struct gb_fw_download_fetch_firmware_response.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: greybus-dev@lists.linaro.org
Cc: linux-staging@lists.linux.dev
---
 drivers/staging/greybus/bootrom.c         | 7 +++----
 drivers/staging/greybus/fw-download.c     | 7 +++----
 include/linux/greybus/greybus_protocols.h | 8 --------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index 79581457c4af..76ad5f289072 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -243,10 +243,10 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 	struct gb_bootrom *bootrom = gb_connection_get_data(op->connection);
 	const struct firmware *fw;
 	struct gb_bootrom_get_firmware_request *firmware_request;
-	struct gb_bootrom_get_firmware_response *firmware_response;
 	struct device *dev = &op->connection->bundle->dev;
 	unsigned int offset, size;
 	enum next_request_type next_request;
+	u8 *firmware_response;
 	int ret = 0;
 
 	/* Disable timeouts */
@@ -280,15 +280,14 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 		goto unlock;
 	}
 
-	if (!gb_operation_response_alloc(op, sizeof(*firmware_response) + size,
-					 GFP_KERNEL)) {
+	if (!gb_operation_response_alloc(op, size, GFP_KERNEL)) {
 		dev_err(dev, "%s: error allocating response\n", __func__);
 		ret = -ENOMEM;
 		goto unlock;
 	}
 
 	firmware_response = op->response->payload;
-	memcpy(firmware_response->data, fw->data + offset, size);
+	memcpy(firmware_response, fw->data + offset, size);
 
 	dev_dbg(dev, "responding with firmware (offs = %u, size = %u)\n",
 		offset, size);
diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
index 543692c567f9..2d73bb729aa2 100644
--- a/drivers/staging/greybus/fw-download.c
+++ b/drivers/staging/greybus/fw-download.c
@@ -271,11 +271,11 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
 	struct gb_connection *connection = op->connection;
 	struct fw_download *fw_download = gb_connection_get_data(connection);
 	struct gb_fw_download_fetch_firmware_request *request;
-	struct gb_fw_download_fetch_firmware_response *response;
 	struct fw_request *fw_req;
 	const struct firmware *fw;
 	unsigned int offset, size;
 	u8 firmware_id;
+	u8 *response;
 	int ret = 0;
 
 	if (op->request->payload_size != sizeof(*request)) {
@@ -325,8 +325,7 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
 		goto put_fw;
 	}
 
-	if (!gb_operation_response_alloc(op, sizeof(*response) + size,
-					 GFP_KERNEL)) {
+	if (!gb_operation_response_alloc(op, size, GFP_KERNEL)) {
 		dev_err(fw_download->parent,
 			"error allocating fetch firmware response\n");
 		ret = -ENOMEM;
@@ -334,7 +333,7 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
 	}
 
 	response = op->response->payload;
-	memcpy(response->data, fw->data + offset, size);
+	memcpy(response, fw->data + offset, size);
 
 	dev_dbg(fw_download->parent,
 		"responding with firmware (offs = %u, size = %u)\n", offset,
diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
index aeb8f9243545..603acdcc0c6b 100644
--- a/include/linux/greybus/greybus_protocols.h
+++ b/include/linux/greybus/greybus_protocols.h
@@ -232,10 +232,6 @@ struct gb_fw_download_fetch_firmware_request {
 	__le32			size;
 } __packed;
 
-struct gb_fw_download_fetch_firmware_response {
-	__u8			data[0];
-} __packed;
-
 /* firmware download release firmware request */
 struct gb_fw_download_release_firmware_request {
 	__u8			firmware_id;
@@ -414,10 +410,6 @@ struct gb_bootrom_get_firmware_request {
 	__le32			size;
 } __packed;
 
-struct gb_bootrom_get_firmware_response {
-	__u8			data[0];
-} __packed;
-
 /* Bootrom protocol Ready to boot request */
 struct gb_bootrom_ready_to_boot_request {
 	__u8			status;
-- 
2.34.1

