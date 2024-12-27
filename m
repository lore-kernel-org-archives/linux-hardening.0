Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C11F4289;
	Fri, 27 Dec 2024 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735305824; cv=none; b=Jkt2yLjjJ1U+5HqFFzWCu/cOkp4MuGYv+giZd6JKxgOfv/dvigVCM7ejGQ3VektrEuX2p5HlaExZ1wBJAkNgYHrSxESSkun+CT3EDKNTTQqIJU1EvPe2Xftu7Fu5K6/aLLjBP4s6rD5k73Pxu5bv7V/YcrBURKiwox00oKHkyPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735305824; c=relaxed/simple;
	bh=1M2tTpAy7wfVnlolmJhZVJTvVJUA0t3iMiX4U0A1FJU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZYAE9dljxPSrIXJIX2TI9j2tCVLIgqV5/rlAEcRtOXZu8w5hcNbDs8i2FPD00V72lPfmEancq7drV6O1pVBNqDeCebkMYub6OCACRFKHl2FdaWjsOA9UHqjS6Slmw+TAyrEQNmHiFRIUc9Mxkfa0d0xBX5gxtx/pGnJZlsJQ+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ngc6xp8n; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ngc6xp8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735305810;
	bh=1M2tTpAy7wfVnlolmJhZVJTvVJUA0t3iMiX4U0A1FJU=;
	h=From:Subject:Date:To:Cc:From;
	b=ngc6xp8nCMCiZXQrlHxsrVL1c9mygTAZHRHSqME/gGr3jFV/FG0CLxRsbrKV+Sez3
	 YL0y1StOkPJ7PP2XbYG+Xtti7Rh32hqA1Q5vxznrlGdHHMikN2H8jNqI+PIcLgqweN
	 iDCwHUrdHq5Lx6iJAPfom5MXnGW8WayRNPL2kMWA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/6] module: sysfs: Cleanups and preparation for const
 struct bin_attribute
Date: Fri, 27 Dec 2024 14:23:19 +0100
Message-Id: <20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEeqbmcC/33NQQ6CMBCF4auQrh1DS0Fx5T0MMVAGO4m2plNQQ
 ri7lcSty/8tvrcIxkDI4pQtIuBETN6lULtMGNu6GwL1qYXKlZZKlsAzDwzGO47Qkbu2MQZ4+H6
 8I3SYl4Wu6uLQViIJz4ADvTf90qS2xNGHeTub5Hf9udVfd5KQw3CUqGsstUF9fiExs7Gj3TuMo
 lnX9QNAR5lIywAAAA==
X-Change-ID: 20241215-sysfs-const-bin_attr-module-be05346937a6
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735305809; l=1125;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1M2tTpAy7wfVnlolmJhZVJTvVJUA0t3iMiX4U0A1FJU=;
 b=UMSCeRKNt1O50CT7qkMEb2Dwi0UnwQBzaN6jgEYNGV8+FjPbraTBDLqYfPGoDvkyOEuD3m5CN
 e9SbteCREPXD4ujUINUoWDI/GPHl79lEoFbQqJj1pIsv6Rdu2eEQ7Jr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core is switching to 'const struct bin_attribute's.
Prepare for that.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Avoid NULL-deref in free_sect_attrs()
- Avoid double-free and NULL-deref in free_notes_attrs()
- Also drop 'struct module_sect_attr'
- Link to v1: https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-module-v1-0-f81e49e54ce4@weissschuh.net

---
Thomas Weißschuh (6):
      module: sysfs: Drop member 'module_sect_attrs::nsections'
      module: sysfs: Drop member 'module_sect_attr::address'
      module: sysfs: Drop 'struct module_sect_attr'
      module: sysfs: Simplify section attribute allocation
      module: sysfs: Add notes attributes through attribute_group
      module: sysfs: Use const 'struct bin_attribute'

 kernel/module/sysfs.c | 116 ++++++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 61 deletions(-)
---
base-commit: d6ef8b40d075c425f548002d2f35ae3f06e9cf96
change-id: 20241215-sysfs-const-bin_attr-module-be05346937a6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

