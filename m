Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3532C85
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hn7T3SSr"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0295A4
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:27:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a4fb3e096so1941465276.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976825; x=1697581625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mqff+9SvB3fBY25z9tL0cer8ihfSYj7+UyD+m2ojB+8=;
        b=hn7T3SSrBObKD9vVFQUWWB0nrV91BOgNe+UcOcTmT7t7RawDZXZ1cJewovRKpJY0ZL
         oDQQx3SZtrIYHZkAxorbChMMV/t8laEMCiOFSvluVK5uf8usVUbN9g86Op0R3De/y8RT
         UHMY84lCwA+uc/niAkRs2scknnenKXBCHOpY9QPfTd31GMrm8/YH6+5UZ8z12ewQbrW0
         qx2gfdXGw6Vr2GY77tJFbK5Tcw93lDz93bdgdOcXBBNVi8P+Y1z9racpCaowjv4GksZe
         nS37xTsWkfzDZS711mTKqfsPfDNil2xhuI0zMsbxYs7SvYfF4jDQz3C31RRH/vRUy4rN
         Cu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976825; x=1697581625;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqff+9SvB3fBY25z9tL0cer8ihfSYj7+UyD+m2ojB+8=;
        b=CNOJTvyOvsmyTvFaOuak/7Pt+RDB+unBysP58vboOBtO1qE21IOKWrWmmJLAWw4alS
         TZMbHsSYnJv9rWXDYj3G/9T1NW94lY7HPJb+8VXeCZRmECkZhdC/FvU3/WwcERELbVa5
         efQJdNY2iLRhiyPA+SD3Lqwuj28Sq6YV/NWHu4EH4nNwx4kuCsuLaCC+QJLnj/ncW3u/
         vtxpMkmR64kICZE/WpG0Gz+1DLz+l0urPiUWRhu83BmipFLd2h1Kwg3JjxfVCcM2mgVk
         Irk18uJIqLTUGJgpdqMqsTKxhupHaSkJ5TvfJJxMCSN0ZvHJfYhF8nuAA7uJ6oWAdxf8
         k4tA==
X-Gm-Message-State: AOJu0YzUXEhYBX0RwplpwV63qBZmZVK3CCp3PJVDk4EQfzhhi3fG6s3i
	6jntgvcOQgH7GkhzmonXVWFPIeQYK1o6fJvPfw==
X-Google-Smtp-Source: AGHT+IHraAII69a0aP4H4gUX+XoxQ3XrNIHW4Gwc/C6sng3MZIlHkz72ifEwjxe4Zr7sZuAZ7NQjtNagMZnt1yX0Dg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:8a0d:0:b0:d81:7617:a397 with SMTP
 id g13-20020a258a0d000000b00d817617a397mr352834ybl.9.1696976825766; Tue, 10
 Oct 2023 15:27:05 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:26:53 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK3PJWUC/yXNwQrCMBCE4Vcpe3YhaUHQVxEPMTtqQGLIhtBS+
 u7d6vGfwzcrKWqC0nVYqaInTd9s4U8DxXfIL3ASaxrdOHnnHWc0QeeK8gkRrK3mWBZrRRYOyn+ QBbg4cfE8PYRMKxXPNP+ebtT9MRll3Nzovm07eajTV4kAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976824; l=3112;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=xvGZD5tJaO6+F4XyQY6/aAG8nI/QHpdZbkaTXLOae38=; b=ZUNsueoPkwbd0dBafrZ61XOzzilo+aMtXgdstoGrSelvS82fo2raZLSDrWZAsbk+OrkDtUx4l
 P1sYqwtfcssAwA1lCB1wgfMwcezaDYwjJ0lWQ8ez5Nba0zkDIaIfHu4
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Subject: [PATCH net-next 0/7] net: intel: replace deprecated strncpy uses
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This series aims to eliminate uses of strncpy() as it is a deprecated
interface [1] with many viable replacements available.

Predominantly, strscpy() is the go-to replacement as it guarantees
NUL-termination on the destination buffer (which strncpy does not). With
that being said, I did not identify any buffer overread problems as the
size arguments were carefully measured to leave room for trailing
NUL-bytes. Nonetheless, we should favor more robust and less ambiguous
interfaces.

Previously, each of these patches was sent individually at:
1) https://lore.kernel.org/all/20231009-strncpy-drivers-net-ethernet-intel-e100-c-v1-1-ca0ff96868a3@google.com/
2) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com/
3) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-fm10k-fm10k_ethtool-c-v1-1-dbdc4570c5a6@google.com/
4) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com/
5) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com/
6) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com/
7) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com/

Consider these dead as this series is their new home :)

I found all these instances with: $ rg "strncpy\("

This series may collide in a not-so-nice way with [3]. This series can
go in after that one with a rebase. I'll send a v2 if necessary.

[3]: https://lore.kernel.org/netdev/20231003183603.3887546-1-jesse.brandeburg@intel.com/

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Justin Stitt (7):
      e100: replace deprecated strncpy with strscpy
      e1000: replace deprecated strncpy with strscpy
      fm10k: replace deprecated strncpy with strscpy
      i40e: use scnprintf over strncpy+strncat
      igb: replace deprecated strncpy with strscpy
      igbvf: replace deprecated strncpy with strscpy
      igc: replace deprecated strncpy with strscpy

 drivers/net/ethernet/intel/e100.c                | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c    | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 8 ++++----
 drivers/net/ethernet/intel/i40e/i40e_ddp.c       | 7 +++----
 drivers/net/ethernet/intel/igb/igb_main.c        | 2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c        | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c        | 2 +-
 7 files changed, 12 insertions(+), 13 deletions(-)
---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-netdev-replace-strncpy-resend-as-series-dee90d0c63bd

Best regards,
--
Justin Stitt <justinstitt@google.com>

