Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0A413D99
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604221; cv=none; b=HjnLjj86L/sfmVLJOurK+BcyZhjJidMIXRkPGguIULSHXEdzgJ+CAWvAo8LtLSPWaodjL3WqzmGbngAEsiqcXHKsVuSMVr5zfmaOBOuzrvyOLNYAv72iGgg++G1yzazfIREMUMeLPyXm7RLSyezdJPM9jMiXGZqBt/EKNBeQ7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604221; c=relaxed/simple;
	bh=cHY9Abcv4JeQfjc0VTlYZepQDXj06t3VGMBSC/q49yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/Rf1cSJ+ZKzI/6uw8k4iWF58mLte/Ll7jS6xPNBT8pXY+1IjC4kAZ5xGfeb/8hRLXyqUajmaHlQ76FV08us6gz14ZiAYpWz/SMYrtwPeXiWkVxKzLhS0xu5ZNtg7DawbPETkBrmtvTkpW7FFpwjwqDFccG/Ov5IFwjFMfhOvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-45ef4223be7so2473516f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 03:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604217; x=1782209017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3J3dF/rleitNHrIVaZmT+xGJuXa5FDx3AO/xzdX7Ng=;
        b=SadY0bRXtI/bvoXX70wNGILDOBaTDLSVxW+Z137n9O6zY68I9zlKQMw7Jqe1ycMmEm
         ElMuKhx9aHOcU5uPhbA4aSYQyM5RJbQUxqIQCxFM0YAYonvFQsd07rtjeODhaNV4B6et
         MKmxo3h6Nxi7/or9aeVFEpQfIgZpAzcLxN14HNbwO6tlnDCrWL3/8An8iZVuyPcextLl
         r/zSUq/c8V2KszAUMdCkDqjnucxPLmYrOXPDbmHsyydBSfR+IOz+sW6p7u1r4WIYhMGc
         YHMkbjQkxh4fU4+J7PRPjJVa5I8YCASB/NObZdKmTPDPdVAqAlRvg1twqzJ/XBln8kl9
         pz2w==
X-Forwarded-Encrypted: i=1; AFNElJ9IIzfyiUb4kKlSlnAeyRBIbEWf5wu/MiBMt4wWfGsHRtnnHgLxtvg2yIlsrIgIgjd8t3tdRgHmEXc5Q7jU3bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYfUszWZYOfs4hB+SwjAT37drPLDcWbBcl7hhoflXYPip0p7s
	rCoSsxgEdt4bfSkpwaCIkcY2SQXT37XtEj5glaR0qM5PRUC1NlYcHXGp
X-Gm-Gg: Acq92OEUTuEGpX90jWEfEs+A3YyClBmd/KQRYuqldmeodkPgaHUgPBvOzYz/0i/RCAF
	2JvNrxAin6ZD2LC/XmZBnB8iRsiFIOQK2i0LD3SR9Sf+pzi+8fgI8pH5bLSJO6rMSXDpGS6zUFi
	WrfEiL2iHwuda5r+YyHNIKbTT5E19civy+0IWoNe1ctI2tUcpJOts1Y8o8aBuZBVAgTfK1TrapY
	BrBXLwGoH2QG17csL2o8s1EmXEFSwfLvcmr1V+41E0RpWAL1ef4Yvt1StrnY4DWrCCWSQsuEyCq
	S56LBBVJTwSYejYT5s564FHJhnWAXgvfb9yJkByBTm98ID49WXk8fl1e5Kay6zoXpKZwxR4QFbF
	hxGV+xNUHOi4Y83vkvVjELZ6snvnckR2YH72jHRqur+ncvV5ypIo4jALJO2htGRzAGv0t7Qj8xR
	Q0IGEaMZ6FKdM4J7W63lQuj3DLGKl0aRZd3cUjVbdfK3IhS0GHdT2uV/K3Tnm/6H95s0msUQ==
X-Received: by 2002:a5d:5906:0:b0:460:3233:beed with SMTP id ffacd0b85a97d-4619f31b6ddmr3918817f8f.41.1781604216985;
        Tue, 16 Jun 2026 03:03:36 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-35-102.nat.epc.tmcz.cz. [89.24.35.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d4fsm46870652f8f.24.2026.06.16.03.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:03:36 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	Ilya Maximets <i.maximets@ovn.org>,
	Johan Thomsen <write@ownrisk.dk>
Subject: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow in tun_dst_unclone
Date: Tue, 16 Jun 2026 12:03:29 +0200
Message-ID: <20260616100332.1308294-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmalloc_flex() in metadata_dst_alloc() sets __counted_by for the
structure to the options_len, which is then initialized to zero.
Later, we're initializing the structure by copying the tunnel info
together with the options, and this triggers a warning for a potential
memcpy overflow, since the compiler estimates that the options can't
fit into the structure, even though the memory for them is actually
allocated.

 memcpy: detected buffer overflow: 104 byte write of buffer size 96
 WARNING: CPU: X PID: Y at lib/string_helpers.c:1036 __fortify_report
  skb_tunnel_info_unclone+0x179/0x190
  geneve_xmit+0x7fe/0xe00

The issue is triggered when built with clang and source fortification.

Fix that by doing the copy in two stages: first - the main data with
the options_len, then the options.  This way the correct length should
be known at the time of the copy.

It would be better if the options_len never changed after allocation,
but the allocation code is a little separate from the initialization
and it would be awkward and potentially dangerous to return a struct
with options_len set to a non-zero value from the metadata_dst_alloc().

Another option would be to use ip_tunnel_info_opts_set(), but it is
doing too many unnecessary operations for the use case here.

Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Reported-by: Johan Thomsen <write@ownrisk.dk>
Closes: https://lore.kernel.org/netdev/CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com/
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Johan, if you can test this one in your setup as well, that would
be great.  Thanks.

 include/net/dst_metadata.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 1fc2fb03ce3f..f45d1e3163f0 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 	if (!new_md)
 		return ERR_PTR(-ENOMEM);
 
-	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
-	       sizeof(struct ip_tunnel_info) + md_size);
+	/* Copy in two stages to keep the __counted_by happy. */
+	new_md->u.tun_info = md_dst->u.tun_info;
+	memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
+	       ip_tunnel_info_opts(&md_dst->u.tun_info), md_size);
+
 #ifdef CONFIG_DST_CACHE
 	/* Unclone the dst cache if there is one */
 	if (new_md->u.tun_info.dst_cache.cache) {
-- 
2.54.0

