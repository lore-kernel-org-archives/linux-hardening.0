Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YvZQVv7h"
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D583710E;
	Sun,  3 Dec 2023 23:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676351;
	bh=q4VE2o2FyvyFNG1LqUdQPdjkzoeYyweyQ8tzt1Zr98M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YvZQVv7h5D8dBbZC2USl0/LGJ0NYUJBbWTU6gw9zrE5BzBgs6GREiFYl+645cIPQY
	 hbCfQvLOj0lKhEoVRdO1IkXwIAXAzSMwM3JY4WPe0PpDtiIJ7iNlEETgrMwtpB+lZs
	 GNcyUZ4jYSKzKv+EoU/hmUX4GwERfFyKXIZx5FhU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:15 +0100
Subject: [PATCH v2 02/18] sysctl: delete unused define
 SYSCTL_PERM_EMPTY_DIR
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=622;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=q4VE2o2FyvyFNG1LqUdQPdjkzoeYyweyQ8tzt1Zr98M=;
 b=w9UTx2HponGUKe8TWC0etLx9EWRzxuN1D/Eju+YpMZkSFCuCRce0znWXJDyiwUfDfeENARdb8
 gNbmedabRpLB4Cu3/U/T/SDS4VwIA3XWLFu2VK3XeTU44B3TFShYaa0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

It seems it was never used.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysctl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 61b40ea81f4d..26a38161c28f 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -255,8 +255,6 @@ extern int unaligned_enabled;
 extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
 
-#define SYSCTL_PERM_EMPTY_DIR	(1 << 0)
-
 #else /* CONFIG_SYSCTL */
 
 static inline void register_sysctl_init(const char *path, struct ctl_table *table)

-- 
2.43.0

