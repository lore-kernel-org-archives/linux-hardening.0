Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45323EB810;
	Tue, 17 Mar 2026 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770988; cv=none; b=kMniCi1YWb2DoC0zjE9+VQvRPomRK5cGEGsvNVfRzbu71dejzr6wwuxDTvQhXAzFndOmTiaAbQvZ/GHAN+kpv6Aw9CigMkJSotpb8cxm7a3M5QdLLZl8OUDHC7daJ3VDFpnsAQAuNlQxWlYQHTdoCNCq7OqFJw+B97yFmBR8ne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770988; c=relaxed/simple;
	bh=xUBIjCPiqikLumDJV0/ro119OoQ7PDq8BR8ypLrh5DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDc5Ah1aFIK7K+GUX8dvy5J1n6uaWB16AgSwZRGmakzUr5316p7biYJDGsr396NWglkma52JIM1miJqJJUHeyo5ZlhfYdgRqRNBmaUhbzXtVATs80ibe7jqJzJZ2+7V1iPWom49i2JK1Khfo2SlNJbBP82N9FAnz4TKYIAANUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO9bch1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO9bch1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CF2C2BC9E;
	Tue, 17 Mar 2026 18:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770987;
	bh=xUBIjCPiqikLumDJV0/ro119OoQ7PDq8BR8ypLrh5DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iO9bch1QYjwx5A64hjbjXnwvv1lSbjisITynowNNomQaF7acj9NwYa0naYkwxLCjw
	 7zAbSYj8SnnAWXAKj2scVHfqBovy/RQNKuBOjZhkxdoM3mt2P76qMEKHcRO6upc1d1
	 C3l1rt3BSrQ4b0D3SyDffRdIFSL13FDUwbmrvkdO46SyWqeASwMYlCafDuHYHBH+mQ
	 Q6gNkTDqRoctJaEN0GfzuLbsuiCBWkCvArMOK3zq8i79ttKiQde6iqq3xc0A81p9RK
	 G0Nfh26c522cezt0F1o1Sh0iOsFQcHDOmS2sjVo3VNUQftHF/5thXLDwOHAEqNOeie
	 5c2cQBAfnoIRA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrR-0000000H5Hy-3oxl;
	Tue, 17 Mar 2026 19:09:45 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 03/22] docs: kdoc: don't add broken comments inside prototypes
Date: Tue, 17 Mar 2026 19:09:23 +0100
Message-ID: <12ac4a97e2bd5a19d6537122c10098690c38d2c7.1773770483.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773770483.git.mchehab+huawei@kernel.org>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
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
2.52.0

