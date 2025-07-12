Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80753C30
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348254; cv=none; b=iSn6gbD7SeDDIuGZWWzwviSdn2GOY5JTcvbQoYea6AkA/mGiWRIb1nkOVMwEzXlPqdZ/3JdY3X0tC6uVIzPzBnn4UyzD02pAB0vFZR4+u2mAb64gBE8fJykpMxCOCp/jxdmGqLndMQdsuR5hkNJ5unVy13EpgMsOFevQw6OH/XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348254; c=relaxed/simple;
	bh=rSvRLUWMAe58dSbbcgvm2GROMbwpktC12BO8KaC/Xtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVSVwi1g0Qwdvf0EMeMYTm7hGm8CDpTSwxjeMsps1V0tbxz9NqsvUcIjr3h5osHYs0N4tAiKeJbN64qlJD+wzUVd1Vkye9YLI4vdMQ/fCL3Buk+WecXMWId5fzSjouJ+EZcdtOORO2b1tZhLdhygunK7E2qiDUKWRseBDVox2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NadDir1z; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NadDir1z"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso3660244a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348251; x=1752953051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T46arQ9CGRV1YK6Sh4zvgHO2x3QyCmcpI2rbbuJmFA4=;
        b=NadDir1z8QE4WUx9BSZZlpAOrxNjKUoKZnhr3n9/3Ya4Fayo0Wz2JkG17px6CEyK5h
         /Fcf68HDjhiv9IyKKVpxt9EgyGl9xXffi5RCK264xXa0FNWTzAp8WacxZgpqa6JsWG3s
         vD7VouaiZA4maMSUVZZJY4Z1tWr4GB+ZfB9u+6zlFYlqdnQEabyNblC0lzwej8n3CNJk
         8frvRQR6Vb+t7MQDo9SBNMIbjGULKBQe6Lb9rrytfV4oiJHTDWYXAadXALVilSXcmfS0
         8SSn95lx1FuPsxYVHCzFWu96Mq9u+q+PLQPo1E6/LAMp8S+ymZlbz3f+MdyksOzFFi0n
         ZHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348251; x=1752953051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T46arQ9CGRV1YK6Sh4zvgHO2x3QyCmcpI2rbbuJmFA4=;
        b=YwcOsHSIvLduywbe+RXsxgvtuLKO2e6PKW6ps0W3aay8h8CsyyLFx8XcOetjiqBs69
         4AlDMfjT6wjKmVi8yu5pco3o+I+TYAiK5nJNsbY8eCvORic+IOH1cKCQsfsIQIGcpe6l
         ILRtiBC7XKt+fGbx/+evWzJ74zV3o+1FQT2IXytcwBr2nHlBv+Co80+Pa5uA+CjCF9u9
         EFieYMsP9adOUOo3sHHDFcmhoGTQ4XWtTMqJc4qGJQ3nKFXnaJ1o4BMU3J0q4roEboTT
         sEJaEqwbj90bG8lilWQv07pabQtXTcPJYhZuAYdtjhT5Pp+1M5U2P2bDK8CmadjQLJOU
         R6OA==
X-Gm-Message-State: AOJu0YwWZAujTWAUNyEW5p7c9YXx/AmZDX76rEawneD/1fpz+3+cWTMQ
	pfxsk5FbkdTh4Pmqh7wejz7HW7Z+O1Jf7ycbdK2AfYhDHrCBKHDA7/9GO3R1t3cZ
X-Gm-Gg: ASbGnctHraC0fMrrUp5VxGt09oBBwZxCbNg72wUChmTqecdubOahguSLRr2BN5SIv77
	HblHoxrKVPJG8lDbakv9lTGkpWq2Rvl6qkHOjxl1E10kKLczd8MZi/UVqXTP2e2chYwMj0A1X46
	8cgXeyzghS4xE2v9bmz92WWWp7QRCjz/aWrTC2pVV5RxmEvusak803mfN4uZjaWehlatPKmd5Vr
	cikwA4Vt7mOaEQxYIXMXS8862Zf+K7Rnb7QZdtTDzWXhu7ESsgvuZ/zWP4kmqvgaYpJRp6fSQcy
	BDLT/pBa93kJqe69yRPUVTzQE4JVng3wsXLENnxjCA5bpDLl1iNKy1VgAgEuKrlHhawmB5/B+r6
	8Ro4ZYgneW0ZjxQssC4pg70gJJjZjEKS3wnC1AHXHviU1
X-Google-Smtp-Source: AGHT+IETgcinO5Y6KMQUd0+l5l5JrEmFnJd2iEGT5s1K9NVoxHVlsSGtRDJyLgKtDDGmSxLRzwpP0w==
X-Received: by 2002:a17:903:2ac3:b0:237:ec18:eae3 with SMTP id d9443c01a7336-23dede2e018mr118538125ad.4.1752348251377;
        Sat, 12 Jul 2025 12:24:11 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:10 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 00/17] Add Safefetch double-fetch protection
Date: Sat, 12 Jul 2025 19:21:45 +0000
Message-Id: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

SafeFetch is a patch that provides a caching mechanism to user syscalls
to prevent time-of-check to time-of-use bugs in the kernel. SafeFetch
was originally created by Victor Duta, Mitchel Josephus Aloserij, and
Cristiano Giuffrida. Their original research publication and appendix
can be found here [1]. Their patch for v5.11 can be found here [2]. The
testing scripts can be found here [3].

This patchset is not currently intended for production but rather for
use in testing.

I have been forward porting this patchset for about one year now, from
v5.11 to v6.16-rc6. I branched and merged in my own fork the kernel to
keep track of my progress [4].

I have been able to test the patchset with the same CVE used by the
original paper authors for each new version I ported the patchset to
confirm its functionality. I have not tested the performance of the
patchset in different versions in order to verify the original claims of
minimal overheads. I have done limited testing with different compiler
versions to confirm it can compile across clang and gcc versions. I have
not tested recommended kernel configuration variations.

I would love some help testing this patchset more rigorously in addition
to cleaning up any checkpatch warnings or errors that I was unsure of.
Specifically I was hesitant to try to fix macro warnings as some seemed
wrong to me in my limited knowledge.

I also need help fixing up or formatting the dmesg output to be more
consistent with other messages.

[1] https://www.usenix.org/conference/usenixsecurity24/presentation/duta
[2] https://github.com/vusec/safefetch
[3] https://github.com/vusec/safefetch-ae
[4] https://github.com/gatlinnewhouse/linux

Gatlin Newhouse (17):
  Add SafeFetch double-fetch protection to the kernel
  x86: syscall: support caching in do_syscall_64()
  x86: asm: support caching in do_get_user_call()
  sched: add protection to task_struct
  uaccess: add non-caching copy_from_user functions
  futex: add get_user_no_dfcache() functions
  gup: add non-caching get_user call to fault_in_readable()
  init: add caching startup and initialization to start_kernel()
  exit: add destruction of SafeFetch caches and debug info to do_exit()
  iov_iter: add SafeFetch pinning call to copy_from_user_iter()
  kernel: add SafeFetch cache handling to dup_task_struct()
  bug: add SafeFetch statistics tracking to __report_bug() calls
  softirq: add SafeFetch statistics to irq_enter_rc() and irq_exit()
  makefile: add SafeFetch support to makefiles
  kconfig: debug: add SafeFetch to debug kconfig
  x86: enable SafeFetch on x86_64 builds
  vfs: ioctl: add logging to ioctl_file_dedupe_range() for testing

 Makefile                              |    3 +-
 arch/x86/Kconfig                      |    5 +-
 arch/x86/entry/syscall_64.c           |   76 +
 arch/x86/include/asm/uaccess.h        |  211 ++-
 arch/x86/include/asm/uaccess_64.h     |   54 +
 fs/ioctl.c                            |    6 +
 include/linux/dfcache_measuring.h     |   72 +
 include/linux/mem_range.h             |  302 ++++
 include/linux/region_allocator.h      |  188 +++
 include/linux/safefetch.h             |  222 +++
 include/linux/safefetch_static_keys.h |   22 +
 include/linux/sched.h                 |   11 +
 include/linux/uaccess.h               |   30 +
 init/Kconfig                          |    2 +-
 init/init_task.c                      |   11 +
 init/main.c                           |    7 +
 kernel/exit.c                         |   16 +
 kernel/fork.c                         |   17 +
 kernel/futex/core.c                   |    5 +
 kernel/futex/futex.h                  |    4 +
 kernel/futex/pi.c                     |    5 +
 kernel/futex/requeue.c                |    5 +-
 kernel/futex/waitwake.c               |    4 +
 kernel/softirq.c                      |    8 +
 lib/Kconfig.debug                     |    1 +
 lib/Kconfig.safefetch                 |   36 +
 lib/bug.c                             |   10 +
 lib/iov_iter.c                        |   12 +
 mm/Makefile                           |    1 +
 mm/gup.c                              |    4 +
 mm/safefetch/Makefile                 |   11 +
 mm/safefetch/mem_range.c              | 1882 +++++++++++++++++++++++++
 mm/safefetch/page_cache.c             |  129 ++
 mm/safefetch/page_cache.h             |  141 ++
 mm/safefetch/region_allocator.c       |  584 ++++++++
 mm/safefetch/safefetch.c              |  487 +++++++
 mm/safefetch/safefetch_debug.c        |  110 ++
 mm/safefetch/safefetch_debug.h        |   86 ++
 mm/safefetch/safefetch_static_keys.c  |  299 ++++
 scripts/Makefile.lib                  |    4 +
 scripts/Makefile.safefetch            |   10 +
 41 files changed, 5077 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/dfcache_measuring.h
 create mode 100644 include/linux/mem_range.h
 create mode 100644 include/linux/region_allocator.h
 create mode 100644 include/linux/safefetch.h
 create mode 100644 include/linux/safefetch_static_keys.h
 create mode 100644 lib/Kconfig.safefetch
 create mode 100644 mm/safefetch/Makefile
 create mode 100644 mm/safefetch/mem_range.c
 create mode 100644 mm/safefetch/page_cache.c
 create mode 100644 mm/safefetch/page_cache.h
 create mode 100644 mm/safefetch/region_allocator.c
 create mode 100644 mm/safefetch/safefetch.c
 create mode 100644 mm/safefetch/safefetch_debug.c
 create mode 100644 mm/safefetch/safefetch_debug.h
 create mode 100644 mm/safefetch/safefetch_static_keys.c
 create mode 100644 scripts/Makefile.safefetch

-- 
2.25.1

