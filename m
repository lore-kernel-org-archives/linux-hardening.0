Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E34321F2D
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214949; cv=none; b=E+p5xfW3qUy/sWsIC7Pb8VqS/8ngfpWmz26H2aQzJrhM5NbMNtSqGp/s47Srdfv+o0OSeDyanCV5Vnp29bZhs3cwN018ByD5XfTtZET5Vg5pKLvAnvECadhlGlrJkhb2Cqi32T/eZXFKwoUZ9kP++htljRneIbO9on8XsIh2df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214949; c=relaxed/simple;
	bh=D5piSNa/XD7Ir3Er9XoL6m4fTNi2IcT2btEYZrAM68s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQySv7FsB2PjcH3aAXwL5WKuLwfQ04gKrZoGu5zQbgD/awMTSWQd9/qL/HFcLOUs9eYh2KV+xPyZLFWP4PbA/++FfME7U/lL3TpVGpohbIa/na8GcP/47TB7jajJRTbNe4gzHga558SZykea8/1fI+Ie8MT/JonfUo/ZFsYOStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MTNuYHFV; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MTNuYHFV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781214941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDcpN3Rzl0QyU5jzjG6FOrj+H6SLg2mf0yYuFNo/SCc=;
	b=MTNuYHFVszEvVueH1qZgONioyu+YIhcF8kDu28CO04/nH3dj9o1iyNedXd+0o6HFKObi+r
	d6UKiHbw/P6xK878NeeG1sRKmjT3tbPIXcM2ESFbKATgrG7vO1np6GzqXkaV2hc+qCCGtA
	cAUd1IXAKja1OlVzqJyQbGsk7kk9/Ag=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RESEND] i2c: atr: annotate i2c_atr_adap_desc->aliases with __counted_by_ptr
Date: Thu, 11 Jun 2026 23:55:02 +0200
Message-ID: <20260611215501.464405-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=718; i=thorsten.blum@linux.dev; h=from:subject; bh=D5piSNa/XD7Ir3Er9XoL6m4fTNi2IcT2btEYZrAM68s=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnaelsFSn0NZ7tMP/fv8UlBhgC7aFPNhPuVT+90nWSOz Xgx8cDkjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhI6z6G/zkee7vv7D51YVb/ 2tAYtqka95IkzY/+VvZbVPre0m3LgdcM/5QTM5bN3d75+EyLQbnFxilNDBPPpYt22XivmBsepqv 9nQsA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by_ptr() compiler attribute to ->aliases to improve
bounds checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/i2c-atr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/i2c-atr.h b/include/linux/i2c-atr.h
index 2bb54dc87c8e..b52a7b9ec536 100644
--- a/include/linux/i2c-atr.h
+++ b/include/linux/i2c-atr.h
@@ -71,7 +71,7 @@ struct i2c_atr_adap_desc {
 	struct device *parent;
 	struct fwnode_handle *bus_handle;
 	size_t num_aliases;
-	u16 *aliases;
+	u16 *aliases __counted_by_ptr(num_aliases);
 };
 
 /**
