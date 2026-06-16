Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A6406272
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595062; cv=none; b=CAxBdQadPuHgIVMwCQRwZ360jeO45CIhovg2jfwpQkEgMk0BMpL11YVNuzHaYla7Ci3txQrVxPdCk74wk6LL5GGYoSVtBRuB/VL6z+TRrgrRRyXb/s+2VsAXRQaoDBEpbc90bjHYXSqTwge8lZVXsYAbiWXiYPt5CtKEvg6D9Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595062; c=relaxed/simple;
	bh=Yze8Jj0gyAOomTqI9zhEvfckkzyveOPcqSivqnA543k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhnRU47Vwk0Bh5T3hiQ/3Tixa90ro3ojQLdVJVMo+VtXVYoe2DLycxe6M0+HSdpLplenF1wi2SX2D8Wx+jUDcYaUaE2Q7nwg7jGKTGZ/b5X86wmUneIu/NFNKcVRKzHd5gnEkhkMYWmhwJ8Ojw9h3zCh1VCUvgNSrnbIk0zlXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDtau0HE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDtau0HE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf22d29dabso25938355ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781595061; x=1782199861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+WDurAqpK+dkb0URg/+1yUjEvRH9T2h7sdxZWsTGMw=;
        b=IDtau0HEmy/yzCyK9+FzFT+aNCS3RrxlOC9JQcS21masVAu4mTvJqg6HKyaLQiEaDM
         GiKTfiVsVL+VqAf6n9FZhET+amtTWIz6FTaTSqP2uJwZgH/wBARZcVqZSqKkGA8jPb8/
         69SgdDQmlhdi3/UuAlmeTOD/RDtjvfswlfAJn/CMwE+2425Ahw3r6xQCCE+27p2amZUR
         AHrL7F+GxGdKoWlz9qtQzsSdh94WAIUw8Cd/NWSOJoX0w3XYJLL3qC1pfN8ye1CKjAA5
         Zt760/or+Js1uCWbNvHY6Tbpgi/LSmL9wtbST3Okzde6oA6uKwL93OX+QeQl+pJkdHmP
         kaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781595061; x=1782199861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+WDurAqpK+dkb0URg/+1yUjEvRH9T2h7sdxZWsTGMw=;
        b=rpQW6r2bzKu0ntHXuMDZuGw/qqUBs2igfYy38Wgrz0AhVoMq1z9jsZgpBVMiqgszOv
         AAT173Np1fHDewgRH1aA6B1XO0wi5GS9mxM564AleA5iUpts4hK7HFT7KcI9NhqH10Zl
         zbGFlejxjp14KlQpLmwhworjokGNFTw8Nc7hvN5boahEfmd8OEJ0bhrlwkkoC8fjiAwA
         m0rYvs8VrWVxPvmNOQc2gyBmspexVW25vkw5TFjKUFB/DNetlCugCzyvhvP4X+hLYrvC
         q70EMtlJYCAIx1BoL2iveHr/04S7usj1XuOpSOCPL7V2+QEF3A37g88sh7aXt+l6f2NO
         UmyA==
X-Forwarded-Encrypted: i=1; AFNElJ86kG3pNjuyiJAuS+g7SRBDeSdlprU6K73TFG+cMWUvbjzy9e+h/n+EJGuwZn147c+iEAPXQd3cmcYw0zhKRzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8CUnJFGwJSSs/pYOwAxEmA1UR+atB6qra999ITA62p+r0xAI
	ty7OSjZe1kQfns/Mm44KzIMAoIoglBYTJTHHRyA0wi+0bju01YWhZOPb
X-Gm-Gg: Acq92OH8orVtzg4MFBJAaYGBL0N7GERWmzOaTRjSuxto5lp/ryaZilERd2X4gU/KV3K
	jJdKeaZ1bP/xc3SML/sTucLnR6RNdGii755erLjRk6WWbhvM7OcQxnMMTZmL/whRca3xClWL2ro
	joYULh1VdHX/ipw6dvtGfrut93EmOsLUcFKfCxJrUPSmdbXusVaZxy1zz709i9JC0a02ypYFU3g
	A5UJLyrBensJlJqCek1vPwNWlSKkVEnVJwiTIDYLSXCHPA9JWDiZOn5FmnoFreQyG/0cZwtgus9
	fTL+uWvgIn9TztiEZ9ioQUWmY0lfUln+YWqXGM0TnUV7w2/SOQK2De8umsRyeUeX2Do1+557ZSQ
	12MyMw2r7AiePq7EyFmdpMtm9QRNNz1y850eI6XL64SdbNEhYmzV6AbD4VH8JiRxpAPg6JPLbIg
	lptcGFUTOXzCBYIQJQavrgRCjJOT+zUB3PRBzPhqg6BxMtFVwUBXMIwE4=
X-Received: by 2002:a17:903:11cd:b0:2c2:21e9:5a7d with SMTP id d9443c01a7336-2c69a21d05bmr26333555ad.34.1781595060778;
        Tue, 16 Jun 2026 00:31:00 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.200.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433460a60sm147542995ad.76.2026.06.16.00.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:31:00 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Tue, 16 Jun 2026 07:30:53 +0000
Message-ID: <20260616073053.1144730-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Happy to. Short version: ast2600-evb can't hit the SMP timing window,
so I reproduce each missing piece deliberately. The driver code under
test is unmodified -- only the stimulus and the post-race state are
injected. Stock qemu-system-arm (Debian 8.2.2), no QEMU changes.

Three obstacles, and what I did about each:

1. No BIOS to emit POST codes -- an injection module stages bytes into
   the snoop registers via the LPC syscon regmap (SNPWDR + the HICR6
   data-ready bit).

2. QEMU doesn't raise the snoop IRQ for those writes -- after staging,
   the module dispatches it in software with
   generic_handle_irq_safe(sdev->irq), which runs the driver's real
   aspeed_lpc_snoop_irq() -> put_fifo_with_discard() path.

3. The SMP race won't trigger under TCG -- so I reconstruct its outcome
   instead: force the channel-0 kfifo to in=4097, out=1, i.e.
   (in - out) = 4096 > the 2048-byte ring, the exact state a reader
   observes inside the window.

One caveat so it isn't misread: step 3 writes in/out directly, so it
bypasses the new lock. The patched run therefore shows the read path no
longer turns a corrupt (in - out) into a usercopy overflow; the lock's
job of preventing that state is the SPSC argument from the commit, which
TCG can't exercise.

== Tree / config ==

  base:  v7.1-rc7
  clang: 22.1.7 (LLVM=-22; needed for the context-analysis check)
  ARM multi_v7_defconfig + CONFIG_CC_IS_CLANG, WARN_CONTEXT_ANALYSIS,
  SMP, ASPEED_LPC_SNOOP, HARDENED_USERCOPY, PROVE_LOCKING,
  DEBUG_ATOMIC_SLEEP.

  make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=-22 O=build \
       -j$(nproc) zImage

== Run ==

The injection module (full source below the sign-off) creates two
write-only sysfs knobs under /sys/kernel/snoop_test/. The init loads it,
then:

  echo 4096 > /sys/kernel/snoop_test/generate    # fill via the real
                                                  # IRQ path 
  echo 1    > /sys/kernel/snoop_test/adjust_ptrs  # force in=4097/out=1
                                                  
  read(fd, buf, 4096) from /dev/aspeed-lpc-snoop0 # the overflowing read

Build it against the same tree (-DSNOOP_PATCHED for v6, which mirrors the
spinlock the fix adds ahead of @fifo; omit it for the unpatched build).

  qemu-system-arm -M ast2600-evb -smp 2 \
    -kernel build/arch/arm/boot/zImage \
    -dtb build/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb \
    -initrd repro.cpio.gz \
    -append "console=ttyS4,115200 panic=-1" -nographic -no-reboot

== Result ==

Unpatched, read(4096) with in=4097/out=1:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'kmalloc-2k' (offset 0, size 2049)!
   kfifo_copy_to_user / __kfifo_to_user / snoop_file_read / vfs_read
  Kernel panic - not syncing: Fatal exception

Patched: read() returns 2048, no panic; no lockdep or atomic-sleep
splats.

The init is just: mount proc/sysfs/devtmpfs, finit_module() the .ko,
write the two knobs above, then read(4096) from the char device. Full
injection module follows.

Thanks,
Karthikeyan

------ snoop_test_inject.c (build as an out-of-tree module) ------

// SPDX-License-Identifier: GPL-2.0
/*
 * Reproduce the aspeed-lpc-snoop kfifo SPSC-violation post-race state
 * deterministically under QEMU. Two write-only sysfs knobs under
 * /sys/kernel/snoop_test/:
 *
 *   generate <count>  Push <count> POST-code bytes through the *real*
 *                     driver IRQ path: write SNPWDR + HICR6 via the LPC
 *                     syscon regmap, then dispatch the snoop IRQ so
 *                     aspeed_lpc_snoop_irq() -> put_fifo_with_discard()
 *                     runs.
 *
 *   adjust_ptrs <1>   Force the channel-0 kfifo into the state a reader
 *                     observes inside the race window: in = 4097,
 *                     out = 1, so (in - out) = 4096 > the 2048-byte ring.
 *
 * The driver's private channel is reached through a mirror struct whose
 * layout must match drivers/soc/aspeed/aspeed-lpc-snoop.c. The v6 fix
 * inserts a spinlock_t ahead of @fifo -- build with -DSNOOP_PATCHED to
 * mirror that, otherwise the &fifo offset is wrong.
 */
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/version.h>
#include <linux/fs.h>
#include <linux/file.h>
#include <linux/kfifo.h>
#include <linux/miscdevice.h>
#include <linux/regmap.h>
#include <linux/interrupt.h>
#include <linux/irq.h>
#include <linux/irqdesc.h>
#include <linux/device.h>
#include <linux/kobject.h>
#include <linux/sysfs.h>
#include <linux/wait.h>
#include <linux/spinlock.h>
#include <linux/bitops.h>

#define HICR6			0x84
#define HICR6_STR_SNP0W		BIT(0)
#define SNPWDR			0x94
#define SNOOP_DEV		"/dev/aspeed-lpc-snoop0"
#define RACE_OUT		1u
#define RACE_IN			4097u

struct snoop_chan_mirror {
	const void		*cfg;
	bool			enabled;
#ifdef SNOOP_PATCHED
	spinlock_t		lock;		/* added by the fix */
#endif
	struct kfifo		fifo;
	wait_queue_head_t	wq;
	struct miscdevice	miscdev;
};

struct snoop_dev_mirror {
	struct regmap		*regmap;
	int			irq;
	/* struct clk *clk; struct aspeed_lpc_snoop_channel chan[2]; follow */
};

static struct file *snoop_open(struct snoop_chan_mirror **chan_out)
{
	struct file *filp;
	struct miscdevice *md;

	filp = filp_open(SNOOP_DEV, O_RDONLY | O_NONBLOCK, 0);
	if (IS_ERR(filp))
		return filp;

	md = filp->private_data;
	if (!md) {
		filp_close(filp, NULL);
		return ERR_PTR(-ENODEV);
	}

	*chan_out = container_of(md, struct snoop_chan_mirror, miscdev);
	return filp;
}

static ssize_t generate_store(struct kobject *kobj, struct kobj_attribute *attr,
			      const char *buf, size_t len)
{
	struct snoop_chan_mirror *chan;
	struct snoop_dev_mirror *sdev;
	struct file *filp;
	unsigned int count, i;
	int rc;

	rc = kstrtouint(buf, 0, &count);
	if (rc)
		return rc;

	filp = snoop_open(&chan);
	if (IS_ERR(filp))
		return PTR_ERR(filp);

	sdev = dev_get_drvdata(chan->miscdev.parent);
	if (!sdev || !sdev->regmap || sdev->irq <= 0) {
		filp_close(filp, NULL);
		return -ENODEV;
	}

	for (i = 0; i < count; i++) {
		/* Stage the snoop'ed byte and the data-ready status bit. */
		regmap_write(sdev->regmap, SNPWDR, (u32)(i & 0xff));
		regmap_write(sdev->regmap, HICR6, HICR6_STR_SNP0W);

		/*
		 * Dispatch IRQ -> aspeed_lpc_snoop_irq() ->
		 * put_fifo_with_discard(). generic_handle_irq_safe() copes
		 * with the GIC requiring the handler to run with IRQs off.
		 */
		generic_handle_irq_safe(sdev->irq);
	}

	filp_close(filp, NULL);
	return len;
}

static ssize_t adjust_ptrs_store(struct kobject *kobj, struct kobj_attribute *attr,
				 const char *buf, size_t len)
{
	struct snoop_chan_mirror *chan;
	struct file *filp;
	struct __kfifo *kf;
	unsigned int val;
	int rc;

	rc = kstrtouint(buf, 0, &val);
	if (rc)
		return rc;
	if (val != 1)
		return -EINVAL;

	filp = snoop_open(&chan);
	if (IS_ERR(filp))
		return PTR_ERR(filp);

	kf = &chan->fifo.kfifo;
	/* Reproduce the race outcome: fresh 'in', stale 'out'. */
	WRITE_ONCE(kf->out, RACE_OUT);
	WRITE_ONCE(kf->in, RACE_IN);
	pr_info("snoop_test: in=%u out=%u (in-out=%u, size=%u)\n",
		kf->in, kf->out, kf->in - kf->out, kf->mask + 1);

	filp_close(filp, NULL);
	return len;
}

static struct kobj_attribute generate_attr =
	__ATTR(generate, 0220, NULL, generate_store);
static struct kobj_attribute adjust_ptrs_attr =
	__ATTR(adjust_ptrs, 0220, NULL, adjust_ptrs_store);

static struct attribute *snoop_attrs[] = {
	&generate_attr.attr,
	&adjust_ptrs_attr.attr,
	NULL,
};
static const struct attribute_group snoop_group = { .attrs = snoop_attrs };
static struct kobject *snoop_kobj;

static int __init snoop_test_init(void)
{
	int rc;

	snoop_kobj = kobject_create_and_add("snoop_test", kernel_kobj);
	if (!snoop_kobj)
		return -ENOMEM;

	rc = sysfs_create_group(snoop_kobj, &snoop_group);
	if (rc) {
		kobject_put(snoop_kobj);
		return rc;
	}
	return 0;
}

static void __exit snoop_test_exit(void)
{
	sysfs_remove_group(snoop_kobj, &snoop_group);
	kobject_put(snoop_kobj);
}

module_init(snoop_test_init);
module_exit(snoop_test_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("aspeed-lpc-snoop kfifo race post-state reproducer");
