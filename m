Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BAC376EE
	for <linux-hardening@vger.kernel.org>; Sun, 18 Feb 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277898; cv=none; b=CiARvnSHVBMmlYwsnRrgOKn5b6uoAPmafvcSI1/ST6tANJUcfOgo8LLS1jisoYSNsll8f1p3j4BfB7ABFhTEcDT0hRaVt6mKaxhN691ktUEekL4+OnKzcd2vr03+ileMwmJ1sPw+r30LtKWgRB3PAdZR2BHu3pXzSe7G9PtMZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277898; c=relaxed/simple;
	bh=fOi63sMG14wosBcU+xQx6Pnzfjt7UBebBFJw8HndHpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kW/LR8E76Nz9GxoDXTihx2eGpQDEqYcSzxzbn+IitmNLEscST6vhstkFTa62oOeQ5T1rs7WdyOKcMHQ6t8j+fJsnatlqVVn1cJ7JI4p1Z0Xwl9ETw+5QZ7neldCca4Qm6ShnIcFKMiQJHyjRHaa3EodKbCkrtSdE0jG5GvVhTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ivoiaAYV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ivoiaAYV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d93edfa76dso18873145ad.1
        for <linux-hardening@vger.kernel.org>; Sun, 18 Feb 2024 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708277896; x=1708882696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh9EATpmgCzyJUwdSpfM2xdtAniiVIGVgEMoMg2JFk0=;
        b=ivoiaAYVOzaieC5nVagJP7XIlISH8ZbXC5Y7LsszclV4Th7DOIj/zdmzci7fZ3sj+G
         qrWfqGTUAchMkhrOESgfi8abpm1FsOW3ypCOoi8Rp6Q0pLKc1lSZLXeQwZabao4DuQin
         DsxYhRv3h1EWI/TsUUwbiHhPjvHw3RXMb1swI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708277896; x=1708882696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hh9EATpmgCzyJUwdSpfM2xdtAniiVIGVgEMoMg2JFk0=;
        b=lebIMCIzQjs1Tilv/QZrjKphdXpYABRaXu6lV3WjBMDl250Ha/YR1RmY0KmMUceq37
         2DZSeKLcfm6PgROCoDI2Sg0GAFnuQUdbkEwaTiHVYZIzXIrR7wBvu9z5/6vvhf+81yCl
         8elz0m5bdGcx7vxRyw3awYB6+mnp+dC61SJVnR0ttjEyR4yzD+YiqEQUnoVADhcnaDqw
         /YhikAy6ezi9Mabhart5ckYsaXjFnmwx1brpYaeH3JbRbXou/hvuWyi9LAxYU/AbZBYR
         TXDo3LTAlrMMH4VMwyBKB5BszS+AFqzQ01Vb2GMJGk1SgMVQpSBqlPzK4JT/BrWTIpa0
         C9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU7B5s1OmVe2wx7Yc+m4hOwDXgLVQA9+lq8h/yCOKBY/YBjko1JX5MpP87LNXCme7uKS8kmiSl7xS7pkyGLzO8c4Ypkxel5l9L/7yv+BlKk
X-Gm-Message-State: AOJu0Yz4ydWz/XIZf7tX4F05XUv0H0uTfNO0tnEJ/oaQSffhZkxLUqDk
	O8IBpUEKnokEB4umbfQSIgsqxOGesaxqnH6O2SjECyPd+6iY10xlBRU+9HGucg==
X-Google-Smtp-Source: AGHT+IFiDFAx5zD5XAyCA55VJU5Pi+d3INaNfFUuFMV5btA5rTZyAGg4fDsBByXEwuCMn2nQIGocBA==
X-Received: by 2002:a17:902:e5d0:b0:1db:e6f6:e284 with SMTP id u16-20020a170902e5d000b001dbe6f6e284mr2525345plf.68.1708277895594;
        Sun, 18 Feb 2024 09:38:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001db4433ef95sm2895483plw.152.2024.02.18.09.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 09:38:14 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kees Cook <keescook@chromium.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Greg KH <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] leaking_addresses: Provide mechanism to scan binary files
Date: Sun, 18 Feb 2024 09:38:12 -0800
Message-Id: <20240218173809.work.286-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3736; i=keescook@chromium.org;
 h=from:subject:message-id; bh=fOi63sMG14wosBcU+xQx6Pnzfjt7UBebBFJw8HndHpI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0kCEiQb58OHQzHl2G7UhYX9JgRRCdCZvoZewO
 AV2DXHyBLOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdJAhAAKCRCJcvTf3G3A
 JuVAD/43HbHPxACwrZxImnCyHR2FGGIldZcjwL9rzxA2xEfpQenKFlWdRFW8KBtc1PV3IS5xGVE
 eq7/yB1FOlcsrXRFpmAaC7wKVVITm5/8HiPRKuxCEe+Dl19v/bi41bBKibOCxTStMBJXScul3Cz
 vAUHiq6GxL/jEQ2nArezBD0VVjHwGbUvMHulFUSvTASAh9E+fPjMPxik5CzMORhxQyiiIk05yYo
 ljFQk6sXP8Q+6kupVRVYiqApWYiT7Upb1oDF4kg3hDNVecbz7e/H1tOu70wBGmJ5jpAlwbr4vSb
 lhj5UOhJL1611IIKaVF3DAQNhpNhw7kvfzk1pQFiCjQLgg9ZLTMV7BIiPxAs1V7heOePYqSxa72
 6XKU4g/oJF+iZrrrvvOT66s/QzgnHOS9vrLT+P4OaY8t7Lhe7uLh5mMnw2Al+mu2D+iOJSwRDqv
 LWAS7tterhyusC68jlEKcikaM17g4NyZkdLuqH2Bd6y6pruDx+qvedQveZbKX3P1Jf2lwyp9/5M
 UXqyzi7KPwT9nENEMPKt3Ry93nALTRwbMtfp/HRp91yCQDxuXtkzJpYAzwN+e8MQb1rAOQoR8Ac
 lklMBifu1KULxvDf7CGaFR9vUix4sBDYJMSisNwimqRPCUPYmjiJ+5DFI/w74nHJnMDXupK/v6N
 pbZ541i eDjibwBg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce --kallsyms argument for scanning binary files for known symbol
addresses. This would have found the exposure in /sys/kernel/notes:

$ scripts/leaking_addresses.pl --kallsyms=<(sudo cat /proc/kallsyms)
/sys/kernel/notes: hypercall_page @ 156
/sys/kernel/notes: xen_hypercall_set_trap_table @ 156
/sys/kernel/notes: startup_xen @ 132

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "Tobin C. Harding" <me@tobin.cc>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Guixiong Wei <guixiongwei@gmail.com>
Cc: linux-hardening@vger.kernel.org
---
 scripts/leaking_addresses.pl | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index e695634d153d..cbaa17c244cc 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -51,10 +51,13 @@ my $input_raw = "";	# Read raw results from file instead of scanning.
 my $suppress_dmesg = 0;		# Don't show dmesg in output.
 my $squash_by_path = 0;		# Summary report grouped by absolute path.
 my $squash_by_filename = 0;	# Summary report grouped by filename.
+my $kallsyms_file = "";		# Kernel symbols file.
 my $kernel_config_file = "";	# Kernel configuration file.
 my $opt_32bit = 0;		# Scan 32-bit kernel.
 my $page_offset_32bit = 0;	# Page offset for 32-bit kernel.
 
+my @kallsyms = ();
+
 # Skip these absolute paths.
 my @skip_abs = (
 	'/proc/kmsg',
@@ -95,6 +98,8 @@ Options:
 	      --squash-by-path		Show one result per unique path.
 	      --squash-by-filename	Show one result per unique filename.
 	--kernel-config-file=<file>     Kernel configuration file (e.g /boot/config)
+	--kallsyms=<file>		Read kernel symbol addresses from file (for
+						scanning binary files).
 	--32-bit			Scan 32-bit kernel.
 	--page-offset-32-bit=o		Page offset (for 32-bit kernel 0xABCD1234).
 	-d, --debug			Display debugging output.
@@ -115,6 +120,7 @@ GetOptions(
 	'squash-by-path'        => \$squash_by_path,
 	'squash-by-filename'    => \$squash_by_filename,
 	'raw'                   => \$raw,
+	'kallsyms=s'            => \$kallsyms_file,
 	'kernel-config-file=s'	=> \$kernel_config_file,
 	'32-bit'		=> \$opt_32bit,
 	'page-offset-32-bit=o'	=> \$page_offset_32bit,
@@ -155,6 +161,25 @@ if ($output_raw) {
 	select $fh;
 }
 
+if ($kallsyms_file) {
+	open my $fh, '<', $kallsyms_file or die "$0: $kallsyms_file: $!\n";
+	while (<$fh>) {
+		chomp;
+		my @entry = split / /, $_;
+		my $addr_text = $entry[0];
+		# TODO: Why is hex() so impossibly slow?
+		my $addr = hex($addr_text);
+		my $symbol = $entry[2];
+		# Only keep kernel text addresses.
+		if ($addr_text !~ /^0/) {
+			my $long = pack("J", $addr);
+			my $entry = [$long, $symbol];
+			push @kallsyms, $entry;
+		}
+	}
+	close $fh;
+}
+
 parse_dmesg();
 walk(@DIRS);
 
@@ -442,6 +467,25 @@ sub timed_parse_file
 	}
 }
 
+sub parse_binary
+{
+	my ($file) = @_;
+
+	open my $fh, "<:raw", $file or return;
+	local $/ = undef;
+	my $bytes = <$fh>;
+	close $fh;
+
+	foreach my $entry (@kallsyms) {
+		my $addr = $entry->[0];
+		my $symbol = $entry->[1];
+		my $offset = index($bytes, $addr);
+		if ($offset != -1) {
+			printf("$file: $symbol @ $offset\n");
+		}
+	}
+}
+
 sub parse_file
 {
 	my ($file) = @_;
@@ -451,6 +495,15 @@ sub parse_file
 	}
 
 	if (! -T $file) {
+		if ($file =~ m|^/sys/kernel/btf/| or
+		    $file =~ m|^/sys/devices/pci| or
+		    $file =~ m|^/sys/firmware/efi/efivars/| or
+		    $file =~ m|^/proc/bus/pci/|) {
+			return;
+		}
+		if (scalar @kallsyms > 0) {
+			parse_binary($file);
+		}
 		return;
 	}
 
-- 
2.34.1

