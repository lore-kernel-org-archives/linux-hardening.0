Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44921A4F0A;
	Fri, 28 Mar 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173789; cv=none; b=f5BtVCcU32aOUIZ7Uhw/gfLcpzt8urPZH2uwPiR5rxZU9kIGH8CW+fUBYSfjdsidORTx2eum0Rp/1s3m1hZxz4WFk2BTHoj0vU0iYD3aBx0nTKSUOApjy7DgxPWTjhJu57gVQSYcG13HO+wBATphLAW9Ti6Kxb2ocRV94EYQHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173789; c=relaxed/simple;
	bh=lSjBRuGPYK0JKv06whQALWhLO84ENRlVPpECtO0w/dY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C50GIIST4cjY7JFaTKMa0KXQOXI03WyEFgE5QBaenEN6qlYHs+/Bcwfo1c7ixduLNuB+02aU1jZe9XUIuWc4Qbn9TpODis17xuOAS6knqiz7Wy9lf8il41+WmqfAEDZyWKphRoYe9+Erl2hWQFTwo3QHEg2FjZEy8uHGqvBiaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8X3+SDf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8X3+SDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889E4C4CEE4;
	Fri, 28 Mar 2025 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743173788;
	bh=lSjBRuGPYK0JKv06whQALWhLO84ENRlVPpECtO0w/dY=;
	h=Date:From:To:Cc:Subject:From;
	b=f8X3+SDfkTTXgQd9yE0i05TbLTXzxg9CqLNviHW1Bw1UGyPNXnFr8h/2ZqYfQdKuI
	 Idh5YqJGJywZpHkYPV9vogfy9Z/+tpg7y1wE0hQjkaAJ36N8xoYRRxBrfHW8Zth2da
	 mZb/LN3AJDDNeWUCaRZt/TMRxoNKaZXrwAquxfoCXDvwAI9p9haMKdWVPmMsn02tlI
	 qHWZasLJJqU58WgDBilMOumWKfavakAloP7ifkFPc7wjC85BUCQvFbMKVjLfFKcoIb
	 6IVlbTW5EjaNkNpDdAjKMAcq7alX/vpwCBnsXg+OWrqTflTpmiO9+Mw1122zj30ABk
	 bhQYcTYw9KqNQ==
Date: Fri, 28 Mar 2025 08:56:25 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau/conn: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z-a4meHAy-t58bcE@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

drivers/gpu/drm/nouveau/nvif/conn.c:34:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nvif/conn.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/conn.c b/drivers/gpu/drm/nouveau/nvif/conn.c
index 9ee18cb99264..5a1a83c62a2a 100644
--- a/drivers/gpu/drm/nouveau/nvif/conn.c
+++ b/drivers/gpu/drm/nouveau/nvif/conn.c
@@ -30,17 +30,17 @@ int
 nvif_conn_event_ctor(struct nvif_conn *conn, const char *name, nvif_event_func func, u8 types,
 		     struct nvif_event *event)
 {
-	struct {
-		struct nvif_event_v0 base;
-		struct nvif_conn_event_v0 conn;
-	} args;
+	DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
+			sizeof(struct nvif_conn_event_v0));
+	struct nvif_conn_event_v0 *args_conn =
+				(struct nvif_conn_event_v0 *)args->data;
 	int ret;
 
-	args.conn.version = 0;
-	args.conn.types = types;
+	args_conn->version = 0;
+	args_conn->types = types;
 
 	ret = nvif_event_ctor_(&conn->object, name ?: "nvifConnHpd", nvif_conn_id(conn),
-			       func, true, &args.base, sizeof(args), false, event);
+			       func, true, args, __struct_size(args), false, event);
 	NVIF_DEBUG(&conn->object, "[NEW EVENT:HPD types:%02x]", types);
 	return ret;
 }
-- 
2.43.0

