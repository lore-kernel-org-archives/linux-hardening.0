Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5F38229E;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=H7iZ743ObBkzDPJ9MXSbJ4MtxK+ND+ad+3pWgwksYtqdcTeWwPVBSrJLveHOr0wBf50QwmZ/E+8juGB85tLCt9bvaJ7KkTOyWdnQYtvQP2yZuocoGNtB33cEFF+r/jpbTB4YC64zpz4gfwO+FvCuXcW+dhowHUc12EsBMi7GT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=csYZ9dA1O9VyUFjc5J0DpD/DghpaaqHq/9OSwq1kYgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkC3mHuh/2KoR3VrLi8XVtEwaqFLIfrtTgOkb9jEId+qKtx3hUWZF9xdkcdZkKKiqDtL0S/ocLNDWd9R3DJKm7rcIv82bMlHHtwHLRM+GdKFnqzmIyM4Br3TB1Sm7GjenKL4Icr0c2EH0eIoQ0GvUuD08rQZcVO+XPUODAAIZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbIhMUX+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbIhMUX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CDFC2BC9E;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=csYZ9dA1O9VyUFjc5J0DpD/DghpaaqHq/9OSwq1kYgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbIhMUX+XkxadUrQIE31OR2aBPxFmGwzypQ/j7wVWH30AThJgrrJ8r89E/Ur4xJ1U
	 As0PRHw5/EWjVJag930+QqY+3iJ8LVPttM0/YT2tIK+38b9V3+vvea4jX+rDQZxlIl
	 umiSIsIsy8YBx7Hm5pBZmM7o2+OnYh05DpkwGpQ2+1m/FtG1yucV+pyJdGeFmUimbw
	 zsvm8DlNzA7WoHgIl8ClURKNFFUeY6VNVC8PQbzBaHR4DBOybEHr4gt6UT8ALu1au/
	 t9KHD4SF9LlXi4huy337VQx+tFWKpkSHX7ZPKCxatBWYUDAK5pyaRhKGYtjoxoPPTR
	 /zAvvwBhaTKGg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077gC-1XAN;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 03/20] docs: kdoc: don't add broken comments inside prototypes
Date: Thu, 12 Mar 2026 08:12:11 +0100
Message-ID: <2b957decdb6cedab4268f71a166c25b7abdb9a61.1773297828.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773297828.git.mchehab+huawei@kernel.org>
References: <cover.1773297828.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Parsing a file like drivers/scsi/isci/host.h, which contains
broken kernel-doc markups makes it create a prototype that contains
unmatched end comments.

That causes, for instance, struct sci_power_control to be shown this
this prototype:

    struct sci_power_control {
        * it is not. */ bool timer_started;
        */ struct sci_timer timer;
        * requesters field. */ u8 phys_waiting;
        */ u8 phys_granted_power;
        * mapped into requesters via struct sci_phy.phy_index */ struct isci_phy *requesters[SCI_MAX_PHYS];
    };

as comments won't start with "/*" anymore.

Fix the logic to detect such cases, and keep adding the comments
inside it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-ID: <18e577dbbd538dcc22945ff139fe3638344e14f0.1773074166.git.mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index edf70ba139a5..086579d00b5c 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1355,6 +1355,12 @@ class KernelDoc:
         elif doc_content.search(line):
             self.emit_msg(ln, f"Incorrect use of kernel-doc format: {line}")
             self.state = state.PROTO
+
+            #
+            # Don't let it add partial comments at the code, as breaks the
+            # logic meant to remove comments from prototypes.
+            #
+            self.process_proto_type(ln, "/**\n" + line)
         # else ... ??
 
     def process_inline_text(self, ln, line):
-- 
2.53.0

