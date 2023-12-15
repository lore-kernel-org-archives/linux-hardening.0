Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB8539D
	for <linux-hardening@vger.kernel.org>; Fri, 15 Dec 2023 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QpluNX1F"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d0bcc0c313so136835ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702599295; x=1703204095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ev3Eb+ZV85HTlWtAyzOBUHGpbBJx18XoGsZ8JgWiqC8=;
        b=QpluNX1FlvOioywUAbxINcLZzpOwHBPA96hPaBjGxXe9xA/LyK27sWz745302R5mpK
         HwZgMNnSdhS0UBn2lGwqAaEvpmIxObANQc8f0sIh/Bw2aqIOuyxHiMrovr+dstkMc2Ot
         eBNxeyquluuSPRnq01gbUFEj7NK5Wv1J3bVX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702599295; x=1703204095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ev3Eb+ZV85HTlWtAyzOBUHGpbBJx18XoGsZ8JgWiqC8=;
        b=nKJksx4cPRn6bdUA+lFieF0H7jtSLOeit6p5tymQOpZMcSqPoSA2DFP1tpTtTyRjdi
         33WAbLw5H/lracUi5rx9TufZcYg5FsoKWNerzGX4ppLxXPmZw02vrUdKEmCGiesBIyD/
         SbJpMeunInQAJBu3grPV7qLSABqrQl//2Or/mocW6y1x0hBnLJ+yoNOzJJMXYQN+EbPN
         VOCpWYgR8Gtd2IDPWqcvEfHinDFV7Hp8gZP7sqpDVkqRTVqUW7LixVK/ymBja7liGqsQ
         P0zsyAdHiFLyLP92YINszd2plfCC18kfmdXXCSo71Fz4/KCEl8/OEVyazM4wAoQZ+Pww
         1XMg==
X-Gm-Message-State: AOJu0Yy3Pu+NtIpZpA7vKdfaAHE87J7lRsLEYgRH2W8hvURygoESv+MB
	hRz9kU5WIe3aim4szhMKgFe71NUgU71y1yIkGx0=
X-Google-Smtp-Source: AGHT+IEjme1NlA6HgwwpB7VS/MhvOHGjbseMV65BUYmIblPAUxil5uGyIbj6X2fNw//Em3FmDKok6g==
X-Received: by 2002:a17:903:2303:b0:1d0:ab57:2483 with SMTP id d3-20020a170903230300b001d0ab572483mr6164845plh.98.1702599295303;
        Thu, 14 Dec 2023 16:14:55 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902c19100b001d352a496c1sm3668670pld.295.2023.12.14.16.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:14:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] scripts: kernel-doc: Report excess struct member descriptions
Date: Thu, 14 Dec 2023 16:14:51 -0800
Message-Id: <20231215001451.work.746-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=keescook@chromium.org;
 h=from:subject:message-id; bh=DsKC5d7CSbsFqjMtjY54c7l6d4gHSd5eMJH8lGLCILM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBle5p7kFwcR+6Zr4eXM4A9sR0wpYZoCKJVSj19A
 HKrKcGjPuOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXuaewAKCRCJcvTf3G3A
 JglID/926jj/4/4MRA201XHEL8z/RFF8dzGN29wtLTO7VSlu16zXONJ1cFL3O78lCO6+aoL+p6D
 LiEdBfm+eWgzO/3A4CGt7W6GEg0P6Bi9kav1WUNN5TjH/qtIIWFEqTKqM+vCI6/8UPNLnvm4uwU
 AWPWhX3O0mVD7Exw08YroCwrLHprq9+7UKYHBiayW3JTjflXYgM8RB3jeNuI7vtL7sOS21xrT8Q
 IxrS9H8lfe0K8HItfd8op6dKQFFN9Oi0pPsIavOUbQNeqM2kwNnwi0zBFzDd1MYU2YkuHUuzkYO
 qlQ9oMJSu0nQcalKsQtjSa8GGIv6LN3vXJilmj8t7p2pjiCsLsavB+YeOATwJFL2+hsRfo07dCa
 aGpvqffvjjwrUwp8DMc/TAeEeQIuwa21YspBGUbYcOpKvGDqDzFa3bN/wQCSlxwem5qpwc3RpCl
 fdD1olKKBacbx5Hov+E64bJtnggvkd+eWFik12U5tjc5bdFilwyif4gooVbSgCPvLZWpxbm6Rs3
 CsQcnbhZFyKp95brTHhhva22cMZ4Px02g9YnhADZ8LuiCzJcHM1LSH9bly/znIAsF1wosVwJ5tw
 6f2W/EPWowJKm6Kd2jZmtz9T2E9zSHAVdxKe6wr58QzQv17SzgCjs1R1LOkXzL7klYskCj5QS4r
 c0PI/rD 11T39bbQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While missing descriptions were already be reported, missing struct
members were not. For example, previously this output was empty, but now
produces:

$ ./scripts/kernel-doc -none ./drivers/leds/leds-mlxreg.c
./drivers/leds/leds-mlxreg.c:42: warning: Excess struct member 'led_data' description in 'mlxreg_led_data'

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/kernel-doc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 08a3e603db19..39e730ee1fef 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1265,6 +1265,18 @@ sub dump_struct($$) {
 		$declaration .= "\t" . $clause . "\n";
 		$level++ if ($clause =~ m/(\{)/ && !($clause =~m/\}/));
 	}
+
+	my %_members;
+	$_members{$_}++ for (@parameterlist);
+
+	while (my ($k, $v) = each %parameterdescs) {
+	    if (!exists($_members{$k})) {
+	        if (show_warnings("struct", $declaration_name)) {
+		     emit_warning("${file}:$.", "Excess struct member '$k' description in '$declaration_name'\n");
+		}
+	    }
+	}
+
 	output_declaration($declaration_name,
 			   'struct',
 			   {'struct' => $declaration_name,
-- 
2.34.1

