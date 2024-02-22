Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799D137910
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639261; cv=none; b=kw2qYved1NLTeA4dM6NV+gvMUN7525Kz+BnV5dpGelXDmAZjsm9v5R//m8ys6TQ/nOCeasvUDi/UC5xognai57b8XqR9RfOIoRsPPcQs9kfGMcrbwFUJ8m1418EK74axJX3h0x7lpTZkVNI9tGxnHm9o9yfRZ3P0G7ulsGEy73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639261; c=relaxed/simple;
	bh=uhlU0x25jSC/q8kWZ2CYfZhoRlBn6ETL7DGvp44hrLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDXGGirWpWrJb9UKd2NgrlM9kuEqiAWoEKxfd4v6BqZWBSOteq0Q+1uiiEtw6Dp0UmqXF2jCV/HE+QjOwuL+YBcG005EPqjNn+I7IjUtx8dtXGLDp8JTByGdnNUuHCs0FcI10Cj0CU2aLm75N3GhJaLnaRZyeZDpqzXARnyKE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JGOW/mVS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGOW/mVS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2998950e951so220390a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708639257; x=1709244057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcbwdGDEaXBLUYjumpG+gsDxnRVJcIomd9ygoS90Aw8=;
        b=JGOW/mVSDOwED/5uKl5hS/1fbO18yhoJZjlAl/nKaWC9D3onMozCO6z/nL9HZR5WwY
         aLqOFBzPw9h6r1FqiqIA4lUOHUhlSOHS8lzv896X5ZlQvTatqET6i1e2bGCRzeg5+8ZE
         RBuUdOeY8uj/x05g0cLgzKhozGJTZcLWtTObs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639257; x=1709244057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcbwdGDEaXBLUYjumpG+gsDxnRVJcIomd9ygoS90Aw8=;
        b=b/ID7pUkM1LzsmQLDTnHux1wCEkF7qzMjMTZsNhYntlE7iTEi8wC/Vc76tTSXnu7sQ
         ih13fHj+giywhatytEgEEvWRELld568TAWy+M8jedT0hGqYW8UXhCWT53zPQR6YmITNh
         fZrnkzt27xLbYE1btVddaQvm3QI1IDFw7IZpcZs/ynzBwh0lnZ+VgC22K/qMNjz4Td2Z
         EP+FcW87rAClkJJ73RxiPwxNNfxZ3WDJ1+NW5E6y1zLXUkK8eBXEo7nFMW8q4V+SRurW
         Vj/GkHT16pI3nAuK/bRdGZX9DZxZB+K028GNxmbT5yknLMYPuc3cxZUH0YoOvUAP6uvW
         WROQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMWzXknn2CtoPrIKjdf3ZvQMO2BmMWIgJ8kcYn3SEbWD2HJdJVGiXECxu2z814qqBpZvM+TY/gpZGrclmtR7QDs27sHnsLWRbHiDqF9csK
X-Gm-Message-State: AOJu0YxCmVyU/vetdDrg7EhnQhHTatTn/A+mkuJoBNEdqwktApJ/5Nq0
	ow+Z9XoSAeZuq32R1l8onw9PeuW3mBZ0bxJT+QCy4Qzajm5KV+ASwYBPGlmXhw==
X-Google-Smtp-Source: AGHT+IGEnaDaYf0U9Tc/6ed2/idKNsq2JaDrlj/AU6Efhg5NWtvvNhaEDnNplUOrc4XSt3GIg9dA7w==
X-Received: by 2002:a17:90a:d504:b0:299:4f5a:62d5 with SMTP id t4-20020a17090ad50400b002994f5a62d5mr105371pju.18.1708639257389;
        Thu, 22 Feb 2024 14:00:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id qn3-20020a17090b3d4300b00298f88c3e48sm4527739pjb.11.2024.02.22.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:00:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <keescook@chromium.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	linux-hardening@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] leaking_addresses: Use File::Temp for /tmp files
Date: Thu, 22 Feb 2024 14:00:49 -0800
Message-Id: <20240222220053.1475824-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222215755.it.764-kees@kernel.org>
References: <20240222215755.it.764-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=keescook@chromium.org;
 h=from:subject; bh=uhlU0x25jSC/q8kWZ2CYfZhoRlBn6ETL7DGvp44hrLQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl18QSRxHv+PncBp1jAJSRPYWJFFgg3pzsNc/fN
 mCVDwrb19WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdfEEgAKCRCJcvTf3G3A
 JjY1EACmTYoMq33mIDZg1J1ccpxT9rC05SHFddeTqn6AUUuJ2ooqezEOEfFFA27Ddk8ijg1xGM3
 pp4Tl54ejn2YBtA10Jgllds3r5mmkKrfT2GkefLJzqOrNQSrWvohbvcv8kLDmDMeO+xEGf1hHr8
 eGKI0ugKLeqPQ6fsCshEypj7+DRbcGmGjdU3/8yWhetBF2iD9R549t+vGn+CWEPvfiM6xTCq+ys
 doU62myz1PWLLntN8N5b09Hn0H2+ab4U+n8TOmOFV1eqNeIDI2jZFhRs1wBbfyCWdpanhHeOmse
 KboyhOh0Mw6EyT7FX/SC0uWN8lhCosFPLHScOu+HjwQTdn1b7jfZHCbLzkelij2t+00aZ15bMno
 G9Pxpi9NI7Wx4+K2iXkxDy9+wRcXr1ThOzZWrFDR1MB6PJ5YUFR2WT/jg+LgNmm8KGdcQyhRimt
 XVfXyHjAkkwmjJNMQpC/aJSXPiI40cTx2Lilx477BccSMsaiCjxbu6hKS91lNIiTikPOeZWZXo1
 1ipvTqdK/uI7PP6reIDKhBHaqDKX/o6RRO5K1bOyGN+HJuBJPCvZUW1iwW8eyCaNQYSffKr2Z6o
 Bm1ejWbbi9wdH5jfO5G41DPQL/oKjxnpQ+fEnMvnE8obItWSmlcsJbRlTR8kolHtrcyAH1fapd1 8SXzHvi1BdKbcLw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Instead of using a statically named path in /tmp, use File::Temp to create
(and remove) the temporary file used for parsing /proc/config.gz.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-hardening@vger.kernel.org
---
 scripts/leaking_addresses.pl | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index e695634d153d..dd05fbcf15c5 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -23,6 +23,7 @@ use strict;
 use POSIX;
 use File::Basename;
 use File::Spec;
+use File::Temp qw/tempfile/;
 use Cwd 'abs_path';
 use Term::ANSIColor qw(:constants);
 use Getopt::Long qw(:config no_auto_abbrev);
@@ -221,6 +222,7 @@ sub get_kernel_config_option
 {
 	my ($option) = @_;
 	my $value = "";
+	my $tmp_fh;
 	my $tmp_file = "";
 	my @config_files;
 
@@ -228,7 +230,8 @@ sub get_kernel_config_option
 	if ($kernel_config_file ne "") {
 		@config_files = ($kernel_config_file);
 	} elsif (-R "/proc/config.gz") {
-		my $tmp_file = "/tmp/tmpkconf";
+		($tmp_fh, $tmp_file) = tempfile("config.gz-XXXXXX",
+						UNLINK => 1);
 
 		if (system("gunzip < /proc/config.gz > $tmp_file")) {
 			dprint("system(gunzip < /proc/config.gz) failed\n");
@@ -250,10 +253,6 @@ sub get_kernel_config_option
 		}
 	}
 
-	if ($tmp_file ne "") {
-		system("rm -f $tmp_file");
-	}
-
 	return $value;
 }
 
-- 
2.34.1

