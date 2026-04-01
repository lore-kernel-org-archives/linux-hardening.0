Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E0230BDB
	for <linux-hardening@vger.kernel.org>; Wed,  1 Apr 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080066; cv=none; b=awyx8+44prtdTfODsXBNuVnkQ1rid67jIXlCE43MRNHMFVg7iqPhUYoIS1iESuGKI2xg1P7jqLM823MBFn/4GOrl8LZ8eIr1LIjfaFglrjQjlO07SBD+SqKTk6SNenWiAWxW7lz/oVIbr7xl4lQIM3dBjAEEFScLI0s9BqWD6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080066; c=relaxed/simple;
	bh=ZOD32CPLt9QK3aMBProd892mYoMeBAWfZ1nsyKYtZeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0ACIzkDujCvoau9liUpcIks/pARcqpBiwqA3ZELMzrhjoKlJZLam/Dbm7IKaOFYL5Kl5wv570Gbp2PIeYG7mgeRBiJ0+pdnd70icnEAVeJzo99fy1Ej3FftC0ew9+XYTWokn6zyS2yssjS6mebz7lo88maKYAqIOpIQz2e+lME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pU/EYg0k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pU/EYg0k"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab46931cf1so9622425ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775080064; x=1775684864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGt1a4sLfrhxByIJ29j9DQkf7gSkmMPtiPiOxDIoUcA=;
        b=pU/EYg0kUPUWlpO4fh8GHmk3QM1FrO+JuYtA9VDMZC2Gtx5GKXRzbEXikPJ3SJs53Z
         0fMG1cbT1BjkwHLIWOt5Y9w0fBnrwp0j7tKvnv+Yt4H3E/N6KzrBMi4Le0StwGMjxkOW
         hKlx/8c9uFIJOocDiTXWkAzC2n3Gy70ryFtHvut7QY4l4Nu4q5U985acrp2Ar2/k7kqO
         Zo5onLx281aXWs4gWpOu3k6uPlwMXAtOuouNj2rLhDq3zGu9fcfGSbz1OdoxVBBlCuUm
         rFkS3cpAbvUVn0471pUlQhz1c94IhVWBI2+sHUK5/nS0hsk0eR02IEudD2fQnjwo76Zh
         CQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775080064; x=1775684864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGt1a4sLfrhxByIJ29j9DQkf7gSkmMPtiPiOxDIoUcA=;
        b=M+FVC/uFqzRHHWvtuE1li7+Mul9C1zWNUV9PxACz/Untpu7uFgvqVvSq+iS1KZnZAw
         gGk31HZkS0Yj2BFptnGKHjBLqYySMHUX2S6SIflcCUteUbAxPPdOQ+OfZbEDY/jICa9T
         Jlq9N8JtrO8mlT8SSId2TUOtlCFGmFdVJsKDteS93kw/PN3/TPJIul9gFRoJkH6pN8i+
         wDW6F5phANYBo3ii80JN7jGww019SUO5CL8keS8dUmdHC/riFdC3jh94f9NRkJj5p5BC
         XuWgeVVLBK9gRxOKnwtakfaYY2pxS6kkU1ICmlxiBvASnzd/BzXi0+HTXBBMU4B7Fbt+
         zWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSxlICIytN6P2pUWO0ztU4XGe3fY41hWAlR7EfA+rWVLxrd7iCEbyQ0cFxIc1xO99rPi58U5Rg20MCuoys1BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKW5y5bLjQxsppMd4UORkhEgN47MY0wWD6yrK+LESk2msotDH
	CBpKRQLZNtVVkkGt+2Q9JYezBFXY7Ng9MxhIlQErrxH/FcBquargmZd/
X-Gm-Gg: ATEYQzzrGdjUNPgMuegvsyWrH7opjNogaBWnjUS9PMmK0uDAiDkJSgDA/yrTlYXeek2
	uaB9rvgUFdrxff0IHcNsPB5Xih6BsDP7rPwnZyIsVbdF78VZajfl3U31ZVrKz9slSJgKMyknkC+
	JNshfdksXnbPLu66oA2OqFDpFRIBDT/bfbZP7KYfa+4K0LwB0NqHFeGjBYX+biMA+VEkBNDXuEM
	ca0oaEWxZQDogIwvwJQddE+c3UMgHjSvKe6Rh143t1hQDnuXd0rMUQA/I0DAfATdEttf5akCMJ8
	/57u8vi5shLYDkhzawtNMMfCSXpXNXBy36md2gIs+HFsgeHRxGEEqQhTUqI5CnOEYpXDRXd/ng1
	AqL21fHcEriXj/4vVz7gG4XpLy7Q6kfubrbyHWY6IZcU0piBxK9Z7B7kjHmJv5gMKxzkk0v/PzK
	X6nqS5s5LMQYMHYE+NwxUPNvyw5eIleRvECgeSoHKTnXAOrtNacSvyk5k=
X-Received: by 2002:a17:903:24e:b0:2b0:6ba2:3d78 with SMTP id d9443c01a7336-2b277d62983mr342125ad.3.1775080064337;
        Wed, 01 Apr 2026 14:47:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm7777625ad.29.2026.04.01.14.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:47:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] thunderbolt: tunnel: simplify allocation
Date: Wed,  1 Apr 2026 14:47:26 -0700
Message-ID: <20260401214726.3911-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member and kzalloc_flex to combine allocations.

Add __counted_by for extra runtime analysis. Move counting variable
assignment after allocation. kzalloc_flex with GCC >= 15 does this
automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: move kernel-doc and reword slightly.
 drivers/thunderbolt/tunnel.c | 10 ++--------
 drivers/thunderbolt/tunnel.h |  5 +++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 89676acf1290..f38f7753b6e4 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -180,19 +180,14 @@ static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths,
 {
 	struct tb_tunnel *tunnel;

-	tunnel = kzalloc_obj(*tunnel);
+	tunnel = kzalloc_flex(*tunnel, paths, npaths);
 	if (!tunnel)
 		return NULL;

-	tunnel->paths = kzalloc_objs(tunnel->paths[0], npaths);
-	if (!tunnel->paths) {
-		kfree(tunnel);
-		return NULL;
-	}
+	tunnel->npaths = npaths;

 	INIT_LIST_HEAD(&tunnel->list);
 	tunnel->tb = tb;
-	tunnel->npaths = npaths;
 	tunnel->type = type;
 	kref_init(&tunnel->kref);

@@ -219,7 +214,6 @@ static void tb_tunnel_destroy(struct kref *kref)
 			tb_path_free(tunnel->paths[i]);
 	}

-	kfree(tunnel->paths);
 	kfree(tunnel);
 }

diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index 2c44fc8a10bc..4878763a82b3 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -37,7 +37,6 @@ enum tb_tunnel_state {
  * @src_port: Source port of the tunnel
  * @dst_port: Destination port of the tunnel. For discovered incomplete
  *	      tunnels may be %NULL or null adapter port instead.
- * @paths: All paths required by the tunnel
  * @npaths: Number of paths in @paths
  * @pre_activate: Optional tunnel specific initialization called before
  *		  activation. Can touch hardware.
@@ -69,13 +68,13 @@ enum tb_tunnel_state {
  * @dprx_work: Worker that is scheduled to poll completion of DPRX capabilities read
  * @callback: Optional callback called when DP tunnel is fully activated
  * @callback_data: Optional data for @callback
+ * @paths: All paths required by the tunnel
  */
 struct tb_tunnel {
 	struct kref kref;
 	struct tb *tb;
 	struct tb_port *src_port;
 	struct tb_port *dst_port;
-	struct tb_path **paths;
 	size_t npaths;
 	int (*pre_activate)(struct tb_tunnel *tunnel);
 	int (*activate)(struct tb_tunnel *tunnel, bool activate);
@@ -107,6 +106,8 @@ struct tb_tunnel {
 	struct delayed_work dprx_work;
 	void (*callback)(struct tb_tunnel *tunnel, void *data);
 	void *callback_data;
+
+	struct tb_path *paths[] __counted_by(npaths);
 };

 struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down,
--
2.53.0

