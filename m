Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88532805
	for <linux-hardening@vger.kernel.org>; Fri, 15 Dec 2023 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MScOnLKC"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-203198c9aa5so93974fac.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 16:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702599337; x=1703204137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3vxsSYcJl7kxjEI0DE/6eMOwd60Yeadj9yTz3Q7bO4A=;
        b=MScOnLKCRwKUM8ocPotQhTx4tecNw1nbnNTnORHhe7DaorVTsZ3sMOtM1KT93SpPqp
         EdYDTLL+uWzNea07LWbnAkh3pOc0rc8oFSnF9rWfb39jiNOrAvTJYnMMi1oHL9PmXWFB
         Y7ghkZ3ZYdWu1ewlhcrG5VrtstzuFRJHFO6gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702599337; x=1703204137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vxsSYcJl7kxjEI0DE/6eMOwd60Yeadj9yTz3Q7bO4A=;
        b=nwFzZ33BRpPtUmIsdcKhxwZ0V92caiPzWugwyxVFnLN/wL0JXv79F61k9i3dv3D7SA
         YP4Fx0ijTI91CxWMUzyrULrA1bY2Bi29CGg6rTFteOXVGUZscK9cYnovWeAUdagLRWWv
         eO5XR87e5wmXT7OBCGm7S0L5HENceiemcn/vc00xRICLEgIynYzb0ysg7u2afrPxNwjL
         ptkV4JJm5fGvftIB7TPBjECUWasee10O6yCm/9UmyfW/BR2y2mzMEWALowPvXYmS/Ap8
         XjQGrj3+K60cdqKqyyyfuk+vQNofr0NhF81wlxCCSxzXfCJ2b5LlnyKYLaXWDwGUNgeF
         lwLQ==
X-Gm-Message-State: AOJu0YyCBbXRopSLEWHeLczuOWg7vVz85PzXDcgdN/k0S6ls5Qa0KgEL
	syafnxQIJNLjOcuKLgjGvnGS8w==
X-Google-Smtp-Source: AGHT+IHFRmua4bfn43gLFDa9bkrDQeU7FxUvYPviaakD/OpweZOXYdoagupozxPjgB1z0T0xAhmzxA==
X-Received: by 2002:a05:6871:5214:b0:1fb:75b:1306 with SMTP id ht20-20020a056871521400b001fb075b1306mr13210128oac.88.1702599337638;
        Thu, 14 Dec 2023 16:15:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm12295937pgg.50.2023.12.14.16.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:15:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] scripts: kernel-doc: Disambiguate origin of warnings
Date: Thu, 14 Dec 2023 16:15:35 -0800
Message-Id: <20231215001535.work.434-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982; i=keescook@chromium.org;
 h=from:subject:message-id; bh=FcgzlnnYVUiulfG4TMJAtGChKc9AwWvF2yVBcOfI0aI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBle5qn/WNMSKjhxrdtusfP6tHCylX5qfzPX7ZUn
 +6z7C4JvVeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXuapwAKCRCJcvTf3G3A
 Jk7TD/9rPD8v7z1WFt7sk+BstGNvtlczv6+GNHoCati8N43Vq/g5880r4J5usQyvVeBe/NoKkWg
 JDAexchPcffhIBQQUYErMVwwoQkxsZIGdJJ+daU1N1ni+9nud2e18HnghYck01L2rOyWlU0g12w
 p6w94ili61MOU2+BRAT5x+hAd7Lx9sz/WbSsIBCf04myb2ogXT5wIb4u/UwUtdu0ee1TEOtptqv
 BhC+w+QMQ0xOOKJgxaLtNzIGUpYNgCxQ0SRUsIItbG6b/wibXgEENCxEc5ftBAEVi1CTXb5mdYH
 CWBVG7fPLuXvXmCXm1+H4hgMpykH0hILIMCoOwHnF8CtPSI50qKMNLzxoRj+Aj7AcmXzGGhUiL4
 MtjlaFPb25DfiK9LWC+p3g3JHIOPGP9JGps8Q1aMn2CyDstZq1dOcsGUgGOBZP54syTB4sn1o+3
 n/ZWEQVnxPPeJooDaT5eW1e6ox1fDqETHxmfXikVb6mdGytc6DGq4UF8BpSqTPHtMw7sctoXn8G
 hUFLdqvhF85y25Hp8/QpgA/tZ6+emZrm+6b6FUnYiLxD9uMTeEYH8mY1lUC79FB/06tS5LzWZ/9
 MpCtLvhiMacbUH2L6d1kuqs5Mnw9a3DcKWViZt8rDiGf9roG0wEN64jndzXM2L+uz4BeECEvtWf
 2bTz9Nv xb5twAtg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

There's no prefix to warnings and errors reported by scripts/kernel-doc
which makes it frustrating to isolate errors reported from CI systems.
Add a "$0: " prefix to all the STDERR output.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/kernel-doc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 41f838042364..2a7b975b03e7 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -450,7 +450,7 @@ sub print_lineno {
 sub emit_warning {
     my $location = shift;
     my $msg = shift;
-    print STDERR "$location: warning: $msg";
+    print STDERR "$0: $location: warning: $msg";
     ++$warnings;
 }
 ##
@@ -1292,7 +1292,7 @@ sub dump_struct($$) {
 			   });
     }
     else {
-	print STDERR "${file}:$.: error: Cannot parse struct or union!\n";
+	print STDERR "$0: ${file}:$.: error: Cannot parse struct or union!\n";
 	++$errors;
     }
 }
@@ -1398,7 +1398,7 @@ sub dump_enum($$) {
 			    'purpose' => $declaration_purpose
 			   });
     } else {
-	print STDERR "${file}:$.: error: Cannot parse enum!\n";
+	print STDERR "$0: ${file}:$.: error: Cannot parse enum!\n";
 	++$errors;
     }
 }
@@ -1469,7 +1469,7 @@ sub dump_typedef($$) {
 			   });
     }
     else {
-	print STDERR "${file}:$.: error: Cannot parse typedef!\n";
+	print STDERR "$0: ${file}:$.: error: Cannot parse typedef!\n";
 	++$errors;
     }
 }
@@ -1993,7 +1993,7 @@ sub process_export_file($) {
     my $file = map_filename($orig_file);
 
     if (!open(IN,"<$file")) {
-	print STDERR "Error: Cannot open file $file\n";
+	print STDERR "$0: Error: Cannot open file $file\n";
 	++$errors;
 	return;
     }
@@ -2102,7 +2102,7 @@ sub process_name($$) {
 	}
 
 	if ($verbose) {
-	    print STDERR "${file}:$.: info: Scanning doc for $decl_type $identifier\n";
+	    print STDERR "$0: ${file}:$.: info: Scanning doc for $decl_type $identifier\n";
 	}
     } else {
 	emit_warning("${file}:$.", "Cannot understand $_ on line $. - I thought it was a doc line\n");
@@ -2320,7 +2320,7 @@ sub process_file($) {
     $file = map_filename($orig_file);
 
     if (!open(IN_FILE,"<$file")) {
-	print STDERR "Error: Cannot open file $file\n";
+	print STDERR "$0: Error: Cannot open file $file\n";
 	++$errors;
 	return;
     }
@@ -2410,14 +2410,14 @@ foreach (@ARGV) {
     process_file($_);
 }
 if ($verbose && $errors) {
-  print STDERR "$errors errors\n";
+  print STDERR "$0: $errors errors\n";
 }
 if ($verbose && $warnings) {
-  print STDERR "$warnings warnings\n";
+  print STDERR "$0: $warnings warnings\n";
 }
 
 if ($Werror && $warnings) {
-    print STDERR "$warnings warnings as Errors\n";
+    print STDERR "$0: $warnings warnings as Errors\n";
     exit($warnings);
 } else {
     exit($output_mode eq "none" ? 0 : $errors)
-- 
2.34.1

