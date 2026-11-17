Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927338;
	b=15rTvvR4FnXEvioSrgJnmQHZYgaw/w72wetvkEG93Z6cHoKbMF3xtZSpPsckgPx1MNL9
	 COVZUhmr/6WqlerK+PANUvOOZ3/lftNfM0VmKekkzvfqnGs5okqV0YLQBrkv+2e/DMeTp
	 eWbASzHMpLgetABAsU1S1zpm4rWiUYXiw99w8pWugrkQNJR/AK+gAm54VPZZxQN/c9V9N
	 Z09pd+H7MB4LzLpMYJau2fV7d/QAiyDdlcJL90P+ta6o0ZNmA8ipPBYjjxSWCBvrgiOYU
	 MOyXGWMZjRZQ0Bykn+CgzOPWd8a5ycUmWuZz190/fj+ELXemClKZZ6HFO7pdQ0yz1uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=tncad3xb72MRHXQPalnrg31jkG++uAFsv3nTcMKPqIc=;
	b=ju8XUeP/7rLs3cpOlFc2kXcSnggtX4zmF+AWozUC0tyw8oSEZcc9v1E2guxZO+ZKf26a
	 0Sg+3+oiJK1cHTyYgwiyZKRgDL2cG/E8xnpNyPTbtflmzcCX/QlVn6zjBUekS+bQtxNwr
	 3t3DFzwdxB7V7TlUgj1yLoj5xBjCz7ffylq7hq4fVc2D+r3DmeiLWcTMPxXIJkDmhZvAK
	 viVdl0lpdWDQothrk72kJXv4ZhhE9gfaA5cC/8Ue0XrPzwvXk/lcyVVtxKwBrNlmYp7x6
	 dkrkvdoNKfh9PiJfqIjHAvotO/Fo3S2hrWFN4uWrGg28ya0mhu+OM1BR09F+ztrU8wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stani.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IQP34qwS;
	arc=none smtp.remote-ip=209.85.128.199
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258DF606A336
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 258DF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stani.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IQP34qwS
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b4dca1ef03so30638927b3.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927337; x=1795532137; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tncad3xb72MRHXQPalnrg31jkG++uAFsv3nTcMKPqIc=;
        b=IQP34qwS8/V2vbPX1ct2YUd3L8ifLBjpH1S7jG2hJRV3H5C/i7uODHJiXl16Pu9KR2
         epROf8+9pjsRRv+vT2cbTahX8aD/5kQNn/yaGewwLMwV02ufL/wCEcVf0Z4LAuiPmR+H
         cG5g8zXXhJFxyC6nENS4R4s2VDitVAN5l8iwWiwi9njfFVYn/sfStFeDBN7jTUrW0g75
         N2puzdxku1uTnHj3YkYPjkCw1/Jygngi8GVJWw6GOkd0wLeVSNvSfA8HqgFGvCg+6XSo
         z2co/Hnotz7w7kHyUZPOd93NL6geLc1V83DCFvDtW7EkKsL2BViXFJ1xlsUy1CG0QxJQ
         D1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927337; x=1795532137;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tncad3xb72MRHXQPalnrg31jkG++uAFsv3nTcMKPqIc=;
        b=FfURD0WV1dwTTXTRiGhKz1tv9Iq9//7vpXWu+pJYpYzzDXCwOX3hN6Gn9yqyz2+niR
         HDxQZWO5a+gKktzab8TIi5K8hQmYUNUZDNR75rCCrGkheboCvHZAgXtmaZHr0wceXrc7
         8ylGRXnrQcU0wMhI6UxVVXMGxot/szlOd3FKgD5m0LJQnLVkN6iwP1d1QF1QykQHOrL9
         6r0FFc1Lnes8KD1XORhCcyGZSCAgDD96pjlcCyaViFqiqK8o8kAGmjkNXe/FrlO+YX/C
         Qg2mY+5KruBRWxAcNwkQARQkxccN+SBTwupGazFFjlXDOJFiauJ5q29AZt5arQWzNogX
         SnKw==
X-Forwarded-Encrypted: i=1; AL+hErHK+1XgtZanJNg6gqHZLwGbrMshRwi8/zeWOYnwtQRwR7HtkJQl4uxbFiIYEyX8o25UtrjousmAnJb4LfdjTPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ePIx1UcdE+Up1aXMg5Q4S5g4p3faikUQQdpWUGLdhuTyjlL2M
	HwbuATEE2gP0nSbwNZ/TIs5lSiwjn8cMT9HVD52ZIjfuDIpjcC7/ES3qli0dUm4bg71tk3d33Hf
	48A==
X-Received: from yxrk12.prod.google.com ([2002:a53:b60c:0:b0:67d:bd70:dbc8])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:408c:b0:677:cbfc:be34
 with SMTP id 956f58d0204a3-67d896e0019mr8711688d50.66.1794927336861; Tue, 17
 Nov 2026 06:55:36 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:06 +0000
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-1-stani@google.com>
Subject: [PATCH iwl-next 00/15] idpf: add PSP offload support, part 1
From: Stan Iliev <stani@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Madhu Chittim <madhu.chittim@intel.com>, 
	Emil Tantilov <emil.s.tantilov@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds PSP (PSP Security Protocol) [1] inline crypto offload
to idpf, through the PSP device API of the PSP core [2]. It comes in two
parts. This is part 1, which adds the control path.

The device encrypts and decrypts the PSP packets. Its control plane
(CP) holds the master keys and the security association database
(SADB) of the TX keys. idpf manages them with new virtchnl2 commands
over the mailbox:
- the CP derives an RX key from a master key and the SPI it allocates,
  one synchronous request per rx_spi_alloc;
- the TX keys are inserted into the SADB asynchronously, in batches of
  up to 101 keys. The SA index that the CP returns for a key goes into
  a TX context descriptor of each of its packets (part 2);
- the SA indexes of the released associations are deleted in batches.

Part 1:
- patches 1-2 wipe the mailbox send buffers on release, as some of the
  messages carry keys;
- patch 3 makes the mailbox workqueue visible in sysfs, like the PSP
  workqueue added later;
- patches 4-7 add the PSP initialization and negotiate the crypto
  offload capabilities, the PSP capabilities and the FIPS compliance
  status;
- patches 8-10 implement the rx_spi_alloc, key_rotate and get_stats
  PSP device ops;
- patches 11-15 add the TX key state, and the insertion of the TX keys
  into the SADB and their deletion.

Part 2 makes idpf_tso() run after the splitq TX resource check,
implements the tx_key_add and tx_key_del PSP device ops and the TX and
RX datapath, and registers the PSP device. Until then, the only change
visible on a device with the crypto offload is the capability
negotiation, which also logs the FIPS compliance status.

PSP is only enabled if the CP grants the new VIRTCHNL2_CAP_CRYPTO
capability, idpf works as before otherwise. The crypto offload API of
the CP uses the virtchnl2 opcodes 560 to 567, the
VIRTCHNL2_EVENT_PSP_ROTATE_KEY event and the VIRTCHNL2_PROTO_HDR_PSP
protocol ID.

Limitations:
- PSP version 0 (AES-GCM-128) and the splitq queue model only;
- the RX datapath only recognizes the IPv6 PSP packet type;
- master key rotations started by the CP itself can't be reported to
  the PSP core, as in mlx5;
- the PSP state doesn't survive a hard reset: the PSP device is
  unregistered at the start of the reset and registered again once the
  reset is done, as in mlx5.

Testing, of both parts on next-queue/dev-queue:
- each patch built with W=1 (allmodconfig) with gcc 15 and clang 21, and
  with gcc without CONFIG_INET_PSP: no warnings in idpf, libie and ixd,
  and no new kernel-doc warnings. checkpatch --strict only asks for
  blank lines between the new virtchnl2.h structures and their
  VIRTCHNL2_CHECK_STRUCT_LEN(), which would break the style of the file;
- tools/testing/selftests/drivers/net/psp.py between two hosts with
  Intel IPU devices (idpf PF, PCI ID 8086:1452), in both directions,
  plus a local case that checks that a connection keeps receiving after
  one key rotation: pass:19 fail:1 xfail:2 skip:11. Same result with RX
  checksum offload off on both hosts, without TCP checksum errors. The
  skips are the IPv4 cases (no IPv4 on these hosts), PSP versions 1 to 3
  and kTLS, the xfails need netdevsim. data_mss_adjust fails since
  commit 3c6e29760c13 ("tcp: Subtract psp_sk_overhead() in
  __tcp_mtu_to_mss() and tcp_mss_to_mtu()."): the routes between these
  hosts have mtu 4220 and advmss 4108, so the PSP overhead no longer
  reduces the 4096 byte MSS, as that commit intends, while the test
  expects a 40 byte reduction. It passed on the same hosts without that
  commit;
- after the tests, the TX keys inserted into the SADB were all deleted
  once their sockets were gone;
- with part 1 only, the hosts boot, negotiate the crypto offload and
  log the FIPS compliance status, without a PSP device.

  An AI coding assistant was used to rework parts of the code and of the
  commit messages of this series after an internal review, and an AI
  code review tool (Sashiko) reviewed the series. I reviewed and tested
  all the changes.

[1] https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
[2] https://docs.kernel.org/networking/psp.html

Stan Iliev (15):
  libie: wipe copied small send buffers on release
  idpf: wipe mailbox send buffers on release
  idpf: make the mailbox workqueue visible in sysfs
  idpf: psp: add psp offload initialization
  idpf: psp: add support for crypto capabilities
  idpf: psp: add support for psp capabilities
  idpf: psp: add support for fips compliance status
  idpf: psp: add support for psp rx key allocation
  idpf: psp: add support for psp key rotation
  idpf: psp: add support for psp statistics
  idpf: psp: add psp tx key state
  idpf: psp: add support for psp tx key deletion
  idpf: psp: add psp work and tx key insertion completion
  idpf: psp: add support for psp tx key insertion
  idpf: psp: add psp tx key registration

 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  15 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  16 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   5 +-
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 738 +++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    |  86 ++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 190 ++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 841 ++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |  23 +
 .../intel/idpf/idpf_psp_virtchnl_def.h        |  24 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  24 +-
 drivers/net/ethernet/intel/libie/controlq.c   |  28 +-
 include/linux/net/intel/virtchnl2.h           | 393 ++++++++
 13 files changed, 2376 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_def.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h


base-commit: 4cd5d9c333fb45a4e70ad6a77c44f13bd7312afb
-- 
2.56.0.679.gc527c65306-goog

