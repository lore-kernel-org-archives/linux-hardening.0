Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190A2BDC32;
	Wed,  8 Oct 2025 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895978; cv=none; b=C73nF5IOGrGZ/kZxMPAvqcds+JQzLzYN+wa71x/nRWUhhYLH5eWDHYY+hl36cZnCs9QFCveCzat7PJx2n0OmLkPR0Gp1yL69CMN2vnaMUHCcaoLHKwDtQoHZLrNrONB8bHDTSF3OY+SAhc3QO8P7wtTn7YV8wxDR3KUO6evXRYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895978; c=relaxed/simple;
	bh=qNjT1AkMsrlGTHoFdpErJ22ljElcPV3fTuggOttYr3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NfU3B0yDThwtrZqcetANiynzcr0nwvu1BI9zmoPCEUVdatc4eKyM43lgnN7EPBusDoKK6YvqP4bBTEWH76WlpbrrVdQG49wHu4iqX+z5tzJtu9PQkSSL6blbIDUWZNKekYic3Xi+BwS4QAEqZIh8RBZGPC4qunXUKvBYc0MwbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWtiZgAg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWtiZgAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5705FC4CEF5;
	Wed,  8 Oct 2025 03:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759895978;
	bh=qNjT1AkMsrlGTHoFdpErJ22ljElcPV3fTuggOttYr3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWtiZgAghGjVIS41h3O76mFd9v2VVcO5VuGk2hNYKMLK4Cg5avhN4bcma7CYBvsA3
	 Hyk+7myoQoKGIH8zkWTI36yg4XZTLZuqpOz0iwoLQPEfJf/ycznMIc6DYPeid6XtA5
	 vYe+saWpysDdf7O/xU89dqA0yqdnx96fF5vK6HHM9Av5F0ZGReBIfmdaDQ6gy0Qipz
	 m5CkHz1Bbkg0PPEAosqtrXj9IUxnZzGGKMwc4A2qDZKJSpqEGEawUm6rUJ2vmvbD3K
	 RjPIw7cIqZvYiniZFB5zi9HEDO5AbH/yV3SYMI8kDS9p7uXpvv4NAQuDmnVuy/zp1w
	 xm7DM/JQVfxvw==
From: Kees Cook <kees@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Hans Verkuil <hverkuil@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] media: dvb-usb-v2: lmedm04: Fix firmware macro definitions
Date: Tue,  7 Oct 2025 20:59:33 -0700
Message-Id: <20251008035938.838263-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008033844.work.801-kees@kernel.org>
References: <20251008033844.work.801-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1974; i=kees@kernel.org; h=from:subject; bh=qNjT1AkMsrlGTHoFdpErJ22ljElcPV3fTuggOttYr3o=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlPHy577VIi+qSi5Mg9MZZLOfzZ1xjYKiabHfJpbBNMU DnPXt3RUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJHn1xkZnv7Kqck2WRhgd+fD jdSyR365f4/UabalyYXozlJv4XqTwfC/Rvvv2aWiKodP7tjJMbndy/zYl0XajtFt2ipJO/4n7Zv IAQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The firmware filename macros incorrectly included semicolons in their
string literal definitions. Right now, this wasn't causing any real
problem, but coming changes to the MODULE_INFO() macro make this more
sensitive. Specifically, when used with MODULE_FIRMWARE(), this
created syntax errors during macro expansion:

    MODULE_FIRMWARE(LME2510_C_S7395);

expands to:

    MODULE_INFO(firmware, "dvb-usb-lme2510c-s7395.fw";)
                                                     ^
                                          syntax error

Remove the trailing semicolons from all six firmware filename macro
definitions. Semicolons should only appear at the point of use, not in
the macro definition.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Malcolm Priestley <tvboxspy@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: <linux-media@vger.kernel.org>
---
 drivers/media/usb/dvb-usb-v2/lmedm04.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/lmedm04.c b/drivers/media/usb/dvb-usb-v2/lmedm04.c
index 0c510035805b..05c18b6de5c6 100644
--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -70,12 +70,12 @@
 #include "ts2020.h"
 
 
-#define LME2510_C_S7395	"dvb-usb-lme2510c-s7395.fw";
-#define LME2510_C_LG	"dvb-usb-lme2510c-lg.fw";
-#define LME2510_C_S0194	"dvb-usb-lme2510c-s0194.fw";
-#define LME2510_C_RS2000 "dvb-usb-lme2510c-rs2000.fw";
-#define LME2510_LG	"dvb-usb-lme2510-lg.fw";
-#define LME2510_S0194	"dvb-usb-lme2510-s0194.fw";
+#define LME2510_C_S7395	"dvb-usb-lme2510c-s7395.fw"
+#define LME2510_C_LG	"dvb-usb-lme2510c-lg.fw"
+#define LME2510_C_S0194	"dvb-usb-lme2510c-s0194.fw"
+#define LME2510_C_RS2000 "dvb-usb-lme2510c-rs2000.fw"
+#define LME2510_LG	"dvb-usb-lme2510-lg.fw"
+#define LME2510_S0194	"dvb-usb-lme2510-s0194.fw"
 
 /* debug */
 static int dvb_usb_lme2510_debug;
-- 
2.34.1

