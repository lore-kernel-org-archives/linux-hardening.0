Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C071EB5F9;
	Mon, 10 Mar 2025 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645471; cv=none; b=slQ+UfYBVxeCN9wx33S0RT1wAmWmxPSEg90IwFRJeyRCDMzuLpmFrqX0GZKMlwFmCie9pBX7lw382Cfg5hK2ZDhUet9gMWyAK75eS3GaycCR91iCeqboCLulAsLD6Nt4mdyT2c7BD/Sbi0rJb04YamYFurkJIOrm1KQLg/jsnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645471; c=relaxed/simple;
	bh=0ZN81sc+mlFXPD8VwpWN1nVUepxowHeMKZ9LyzvkLkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=toQQxDbgdDYBtE7iPbRyE+P2lB3g782cUmNgxu6zHrUVeKsRyZpQXzmjKvHyEijuVa2HbfzHtXwYzNCROhzeEY3JVCt2QOROQ2m5TjppcL6wRWo2xSVqchymrK0C4OVIcDtRBS06RPbJ0Br+oaZn7ofBl66N9fi55IuQ7sjsNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7r1PVQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7r1PVQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A597DC4CEE5;
	Mon, 10 Mar 2025 22:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645470;
	bh=0ZN81sc+mlFXPD8VwpWN1nVUepxowHeMKZ9LyzvkLkU=;
	h=From:To:Cc:Subject:Date:From;
	b=h7r1PVQfBQJaYOOrAHhhhqiJGCTS3m4ZLEQZOzIaVKXi2lgYoLY470E553vr6hNpT
	 APVnllrXACe2xLCBNH7bNMdkqWN5RGgPOYFr001aa7r5rq3tCw22vt09Phm1V7ZSC5
	 g2BdmnkDK/hLA3ArWdBLJr2ElRKQxTjC2Iml1t1l2oB/aS2wpSqWxk6IwZ8E612WYp
	 65LwSrUoIKF0j4oqRhYjEM90x9lMx/qwt/ANXowXFLmCJeWoeBPCSJ+WM4nQMqFrQG
	 shjL8vKYrcbrOadcMYp9nus151Xm/DCzRuykby5O/3IJXSaN0bR2f58rvseEM5zmd1
	 UTOL/Se6xnmsw==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Alex Elder <elder@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] EISA: Increase length of device names
Date: Mon, 10 Mar 2025 15:24:25 -0700
Message-Id: <20250310222424.work.107-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=kees@kernel.org; h=from:subject:message-id; bh=0ZN81sc+mlFXPD8VwpWN1nVUepxowHeMKZ9LyzvkLkU=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn02bcX6GYOZPhqptv5L2EcxfCvvksS2Wp1l0msjxDv Sm2Xb6so5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCIt+xgZbq8p6RV+8Hz1rFuv 1x+6ZWW0YqFQ8I4Ns/XmvnKIMWBtv8nwz1Bo+dLohQlGJtLm55ydoxWnnUlSff1xzYGNAh2Rc44 2sQIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15's -Wunterminated-string-initialization warned about truncated
name strings. Instead of marking them with the "nonstring" attribute[1],
increase their length to correctly include enough space for the
terminating NUL character, as they are used with %s format specifiers.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Alex Elder <elder@kernel.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/eisa/eisa-bus.c | 2 +-
 include/linux/eisa.h    | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index cb586a362944..edceea083b98 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -21,7 +21,7 @@
 
 struct eisa_device_info {
 	struct eisa_device_id id;
-	char name[50];
+	char name[EISA_DEVICE_INFO_NAME_SIZE];
 };
 
 #ifdef CONFIG_EISA_NAMES
diff --git a/include/linux/eisa.h b/include/linux/eisa.h
index f98200cae637..c73a410bf88f 100644
--- a/include/linux/eisa.h
+++ b/include/linux/eisa.h
@@ -28,6 +28,8 @@
 #define EISA_CONFIG_ENABLED         1
 #define EISA_CONFIG_FORCED          2
 
+#define EISA_DEVICE_INFO_NAME_SIZE	51
+
 /* There is not much we can say about an EISA device, apart from
  * signature, slot number, and base address. dma_mask is set by
  * default to parent device mask..*/
@@ -41,7 +43,7 @@ struct eisa_device {
 	u64                   dma_mask;
 	struct device         dev; /* generic device */
 #ifdef CONFIG_EISA_NAMES
-	char		      pretty_name[50];
+	char		      pretty_name[EISA_DEVICE_INFO_NAME_SIZE];
 #endif
 };
 
-- 
2.34.1

