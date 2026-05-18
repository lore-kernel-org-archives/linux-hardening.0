Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2E472792
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113395; cv=none; b=nPOK+k/ie3JTctn8TYa1P2qAiwtoendL2s4vmbTK4/J2k0kU9RW1OoXyGXz7IfWmjK3jIGia8Gjh9QzsEvz9yOtN2lrVmCthk6EJrX1t2YPcF2Mjd9x4FXb+d+6WJyqGmpKn1W3lRm+F3TNLjfKLZTYlEihLxeKM+vSfAzFjtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113395; c=relaxed/simple;
	bh=K2tLBVNBgk0XNMFBF2xJopcAe+AHdugRy9lU7EoXCx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHU3ga+eCdjL6CWzZtt4l8FHynwB1HQqV2Vi16A8EOLgRvoKoLQjv3/YW/L0YiDddxo6ng2DX9NIEvU/EaB4ZY2ClUFRFrS1+gccjFYGIN0n4ApaFDG24gk0tDZ9SL/Jim8/k0cecl6hGddBKvULRNJ3Ue5DEViztyeQyliyDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctEO3nOV; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctEO3nOV"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5102582e237so24224431cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779113391; x=1779718191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8+qzU0W1zzwMpcEaXSpQvWhLzK3bb5pvFaLvwTKH2A=;
        b=ctEO3nOVss7TtOxjMsdlS0Iynr31dC3whau7IexcAJw9cJ1IcDT3Zq1sdkcxDxgzpY
         THw0yZjH7v0cJQG55ddnqzdmFC+DG3C369hGaXgT6ZZfBvSZ3uObG6m1RVyicbsE5p8O
         vmVyL6r6pk3HPTlPptteppmToxBK1iutota/OdEmkrad+3fN9RdAHlHN7QcmASGSS3d/
         eZvlrXMFxS9Oj4oXFIMbtDaAeWIS/aBMbUGeU5wXaDzXh8ktlITM3t/xtdZr5Nvd+PyX
         y6qKHID8LKJCPnTnq0YhgQ1/5lsAUmaeAFJAN8ePPXmDcSaFQOlR4LiCxgo+aLkGLIGG
         UCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779113391; x=1779718191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8+qzU0W1zzwMpcEaXSpQvWhLzK3bb5pvFaLvwTKH2A=;
        b=RyS0QW97CzQ/AcFOpfo83lV+J2FwGYkiPrvV0LUkZIwFdA6Aa2+4u8HILPVOxYSPVG
         7D4xVdPwNlza6I4Qh/HDYOUTlcApuKxQIUwonag1m5IzA9/ertQhwAX8gyfa1RV1ZuKe
         mfiDn/Xo9bVcLtfut8KlZRxcnuz5kg5qhYYsePRCBF9HSzmZ8FhNUlWg2L5Cly6Ms+F1
         HP5jdPu2M8u9leU5wPCcIZSoCsN1His3/H3HiZ+yYb0MjOn2gLK4Ye+FQsbljClZBOBX
         vwby96dxptNq3tdP67gH2wmTh6g8CdmImj3hYZPH1ZMjgM55+ZI0j1Z+ZvBXSEqCIDKo
         3XVg==
X-Forwarded-Encrypted: i=1; AFNElJ8J42W1/exLDzC8jiiIyRZmwvfsroIpEhBO8glvNCJx4Pbq3kpaJZ00Ksvxa4+CcDOlKCzqp/6bdF8Hu0aTxdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4UDKcBk2fgzHj67s2DGf97EL7K5JOPo+Gv+2XUTCFtB0mcJe
	NR6HqgMAYdbE+EVn8jyU3ssIrGkpCrQZwdPgcn2fVaodpTiPqO0THIqM
X-Gm-Gg: Acq92OF5Yg0Cm0IdaUuYrkV3zCHn3rXEdMV/9bBWRQjQYj8/68LbW1USmO36mpqrBx6
	rTUdknSXvKpy2DdBVuWuj0jC1Ju6EKIdT7u7JrvLgedfBdY5mXtZJTiHwqRaDdnH2GWvV9oZQP8
	6X7adlyop7BzqX+ehzuZ9ss/VD1c7wu6krfED3NE/ZAcU696ej3+decSITBRZJgWzsL+oywyLqQ
	ZVw9A5tctnK0iwmQ13HJu2Vtv2m025lgnb7sof1KIWvzKkETZm4u9o1ttccCIMWPe1/HkQKaGxH
	YoVDEROCYd2O9nKCU5U7G8iAF1clBwn1MgURGxoa8LcxMu/IP5/RwwuhHEZMk655wD4JHSnvPoS
	Cb32iuAvYyrZ7pj5s6Db5Elx21ZgKD/QCt1x8lSXB65AR3wylA15JJMCZDRSyY16LGOAmq7745i
	RZFLVKdFnBvllXkCVPmKgA47nNHGuY4P9ulUFY6yDCgInANHETbdAK3lqB/sPcLCoamadp0mWUt
	cz0Cxe0srBS4OTaZqb1sY2PCYfVV/RCpEGIU8oMWxM=
X-Received: by 2002:a05:622a:a1b:b0:516:4f76:aebc with SMTP id d75a77b69052e-5165a0072e8mr213950371cf.1.1779113391191;
        Mon, 18 May 2026 07:09:51 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm139477401cf.3.2026.05.18.07.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:09:50 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [DRAFT][PATCH] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Mon, 18 May 2026 10:09:44 -0400
Message-ID: <20260518140945.2751273-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Disclosure-Status: DO NOT SEND - patch and patch-discipline artifacts pending
Content-Transfer-Encoding: 7bit

drivers/scsi/scsi_transport_fc.c::fc_fpin_li_stats_update() and
fc_fpin_peer_congn_stats_update() walk the on-wire pname_list[]
with a u8 loop counter against the 32-bit __be32 pname_count
field, and never bound pname_count by the descriptor body the
TLV walker already validated.

The two functions are reached on every host running lpfc or
qla2xxx as soon as the fabric controller (well-known S_ID
0xFFFFFD on an FC fabric) emits an FPIN ELS for that initiator;
no host-side capability is required, the fabric is the source.

A pname_count of 256 leaves the u8 condition i < 256 true for
every value i can take, so the walker never terminates: it
takes fc_host->rport_lock once per iteration via
fc_find_rport_by_wwpn() and never releases the calling thread.

Impact: a fabric-side FPIN sender (the elected fabric controller,
a co-tenant N_Port that spoofs S_ID 0xFFFFFD after FLOGI, or a
compromised switch supervisor) can hang the FC ELS receive
thread of an lpfc or qla2xxx initiator indefinitely by emitting
one FPIN ELS frame whose Link-Integrity or Peer-Congestion
descriptor sets pname_count to 256, blocking subsequent FPIN,
RSCN, and multipath-health processing on that HBA function
until reboot.

Switch i to u32 in both walkers and clamp pname_count against
the per-descriptor available bytes (desc_len minus the offset
of pname_list[]) before the loop.  This refuses a malformed
descriptor that claims more entries than its TLV body can hold,
and is the minimum scope that covers both walkers.

I reproduced this on a KASAN-enabled x86_64 mainline kernel at
f0db6484b6ea via an out-of-tree module that allocates a real
Scsi_Host through the FC transport API (fc_attach_transport(),
scsi_host_alloc(), scsi_add_host()), builds a 2096-byte FPIN
payload with pname_count == 256, and calls the exported
fc_host_fpin_rcv() from a kernel thread.  Without the patch, a
bounded watchdog timer fires three seconds into the call with
the kthread still inside fc_find_rport_by_wwpn() (offset
0x14b/0x2b0 in [scsi_transport_fc]) under
fc_host_fpin_rcv()+0x4e8.  The patched-kernel A/B run, the
legitimate pname_count <= 4 regression run, and the checkpatch
and get_maintainer outputs are pending the final patch draft
and will be captured before send.  A reproducer is available
off-list on request.

Two in-tree forwarders reach this code: lpfc passes the full
hardware-reported payload_len with no software clamp
(drivers/scsi/lpfc/lpfc_els.c:10830); qla2xxx clamps
total_bytes to sizeof(item->iocb.iocb) == 64 in
qla27xx_copy_fpin_pkt (drivers/scsi/qla2xxx/qla_isr.c
:1170-1171), so qla2xxx delivers at most 64 bytes of FPIN
payload, but the walker bug fires regardless because the inner
walker never consults desc_len before reading pname_list[i].
qedf, bnx2fc, sw-fcoe and bfa do not forward FPIN ELS to
fc_host_fpin_rcv() in mainline.

The in-flight v10 "fc_els: use 'union fc_tlv_desc'" series from
Hannes Reinecke and John Meneghini (linux-scsi mid
20250926000200.837025-2-jmeneghi@redhat.com) touches the same
file but only changes the descriptor pointer type; the u8 i
counter is preserved verbatim in v10.  Can rebase on top of
that series if it lands first, or land this fix standalone
against current mainline.

Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
