Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42233356773
	for <linux-hardening@vger.kernel.org>; Fri,  4 Sep 2026 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490112; cv=none; b=JgH9w2t0S+r1snqC+1uZXeaR8XKexY1JK2wVlO2+1YVqUQRBg6DxUuQTil2Q69qE7JjAl+xj8CezHvyfJIdKoVVjbllO8At+3+y8+iYpfChZ7AXCJYAILGcGddeD/vB1Ek26EL0c+P8YO01Usi2LQ/+2v44Gq21pX5OsTRNJ9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490112; c=relaxed/simple;
	bh=cK5XxbhXOxCXvBcflUV2pYVwoPtcaOQNtD5vNiyWaTk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KxV0sN/E4rEN9WeFD5iiFxZThW3sToX637s/irC+7gCpPiJC0wgP4EYLIe8sTMo7oeEXQzjGQftvzCuAYrew/KkqX4emEOL7UbfyrMZRYsr8N6bDz6R8Ym9dI69dA6AkAbDtdCZSPMguMipt5x9lGk5QHF4mJ9ARcmwhPbCgXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9XWjlk+; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9XWjlk+"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so758929a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 03 Sep 2026 19:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788490110; x=1789094910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kppunAxcNEE5lV4m1JynLDzX32wrZ6XhwjwL2AKPq8Y=;
        b=c9XWjlk++jepZjMzrgymVDhYBckRervCBFfGVF2mz30oWN5aZIwxEsokPhMIdBpvJg
         XqFy44iPK14Czfs/AUujfgaoMR3tO8jxu95Ck12/Y/OnZs4+ea5OhzuUCnl2Cdj6u3HZ
         D0RW/lAgtt6f+k31zOvPxJGRzFuVdm1wrj87c0K179qF4ay45nWgJXBvXxGOsZbehZUH
         VWmO+oVLUHCoT5tMBvXvdA49CxPDUF9wMCt+EnzuLR7HZbBHOf86wn+VVKE/2cY5hLLm
         zLNmf8yUnfFN3KvRWsdZbY1g0O4BR/2CQw8UhGrVWycXRRmkyCrLpxbn+Q5IgEPPpj7t
         vybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788490110; x=1789094910;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kppunAxcNEE5lV4m1JynLDzX32wrZ6XhwjwL2AKPq8Y=;
        b=JVroJmKvTto/lQAasgAAD4gIv2Zz7DK6eSLRUGWWWOzZ8dc3ZcyoR+DQ5eMG9VFit4
         6DFtsgQzHrjh9XGHWC6n63RLU+wceJDxETv4UFALVeB5fpey0qg0yEd5JuxOhLXU+75Y
         jyP/mOHHXhktK31jBwVm7ONRGAB6XmHMZ9Gn+FC9BSFZngPiSLMxlEgAdzzOivk2DfhY
         QTSz8fGd2jj8nGLRt1dM9xf/L8VaUotGXcPnn6pSzDBqkIDnIIll14RDtB4x580EtMH6
         kJiztb76vMHJ54oxYXVPyZVcaStLsNE1LBKdtjpI9UWg/ZNlTC2+yxKWGDpjbma7eCNV
         3kNw==
X-Forwarded-Encrypted: i=1; AKwUvBxNdtntaYRI994yne8TIFyeWU6tcokT0qFyiw4u+jz4MMkMmPdCAbHHhKTheL3lKZoaR0c42aPWX/TFHsetnTs=@vger.kernel.org
X-Gm-Message-State: AFuF++kaidvQgpAL0Q59kJjYaUEJi/OpnsuKS0xOyiZlFqsOUqsFhM/e
	D1nNj6dTq6axMSm9OkIZkuISAfEH/bdld3MLg1DGiNm6H+WdTNXQJJn04pe5vCGOm9wTNa+PoEL
	8PUeETgMsBxKjsGwhW+63AjqpOjLK1kt1Nw==
X-Received: from pgar19.prod.google.com ([2002:a05:6a02:2e93:b0:cc4:3eb9:12ac])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e081:b0:3b4:61f:1fec with SMTP id adf61e73a8af0-3da39bb593dmr4099789637.2.1788490109174;
 Thu, 03 Sep 2026 19:48:29 -0700 (PDT)
Date: Fri, 04 Sep 2026 02:48:27 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHsxmmoC/32NQQ6CMBBFr0Jm7Zi2RARX3MOwMO0AE7HTtKTRE
 O5u5QAu30v++xskikwJbtUGkTInFl/AnCqw88NPhOwKg1GmUW2tMVgmXNg/kbwLwn5N2F1b0kq
 5i1MNlGWINPL7qN6HwjOnVeLnOMn6Z//3skaNtbFmdG1XU0f9JDItdLbygmHf9y9MPA5atwAAA A==
X-Change-Id: 20260831-pcie-link-endpoints-978e100d5d06
X-Mailer: b4 0.14.3
Message-ID: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
Subject: [PATCH v2 0/3] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>, 
	sashiko-bot@kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn, Ilpo, and the PCI community,

This patch series introduces upstream Linux kernel support for PCIe Lane Ma=
rgining
at Receiver (LMR) per PCI Express Base Specification Revision 7.0 / 6.0 (=
=C2=A7 7.7.11
and =C2=A7 8.4.4).

During the review of the previous v7 standalone LMR submission
(https://lore.kernel.org/linux-pci/20260828-pcie-lmt-v7-1-6012e9e0940a@goog=
le.com/),
Ilpo J=C3=A4rvinen pointed out that feature drivers resolving link partners=
 duplicate
link traversal logic that is already present in drivers such as ASPM:

  "This feels like duplicating similar functionality with the aspm driver
   that also wants to infer ends of the link when giving a pci_dev in.
   The aspm driver currently does that within, but it kind of duplicating
   pci_bus. It would be nice to avoid the duplication and have something
   similar for this in PCI core."

In response to this feedback, the implementation is factored into a clean,
modular 3-patch stack:

1. Patch 1/3 (PCI: Add pcie_get_link_endpoints() helper):
   Standardized, race-safe helper in drivers/pci/pci.c and include/linux/pc=
i.h
   to identify both ends of a point-to-point PCIe link. Safely inspects the
   subordinate bus under down_read(&pci_bus_sem) and acquires a reference
   (pci_dev_get()), paired symmetrically with pcie_put_link_endpoints().
   Filters for Function 0 (with ARI support), validates bridge ownership
   (child->self =3D=3D pdev) to prevent ABA pointer reuse, and handles RCiE=
P
   and empty downstream ports (-ENODEV).

2. Patch 2/3 (PCI/ASPM: Add pci_aspm_inhibit() helper for temporary link st=
ate suppression):
   Reference-counted mechanism (aspm_inhibit_cnt) in drivers/pci/pcie/aspm.=
c
   to temporarily disable ASPM state transitions (L0s, L1, L1SS) on an acti=
ve link.
   Guarantees callers hold down_read(&pci_bus_sem) (via lockdep_assert_held=
_read),
   eliminating deadlocks and preventing power-saving transitions while hard=
ware
   link characterization is in progress.

3. Patch 3/3 (PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support):
   Implements the core LMR driver (CONFIG_PCIE_LMR) in drivers/pci/pcie/mar=
gin.c
   exposing a debugfs interface under /sys/kernel/debug/pci/pcie_lmr_<dev>/=
.
   Strictly self-contained: 0 modified lines in drivers/pci/pci.c, pci-driv=
er.c,
   or core drivers/pci/pci.h. Exposes clean lifecycle hooks in drivers/pci/=
probe.c
   and drivers/pci/remove.c, supports 2D timing and voltage margining acros=
s
   physical receivers (0..6), enforces Function 0 endpoint filtering (=C2=
=A7 7.7.11),
   and includes an exhaustive kselftest suite (tools/testing/selftests/pcie=
_lmt/).

- Capability Discovery (=C2=A7 7.7.11): Probed via Extended Capability ID 0=
x27 on
  Gen4+ (>=3D 16 GT/s) physical links. Differentiates optional support on G=
en4/Gen5
  from mandatory capability presence on Gen6+ (>=3D 64 GT/s).
- Multi-Function Device Scope (=C2=A7 7.7.11): Enforces that capability reg=
istration
  is strictly restricted to Function 0 on Endpoints / Upstream Ports.
- Payload Decoding (Table 4-77, Cmd 88h): Accurately decodes Margin Control
  Capabilities (Bits 0..4); preserves Bits 7:5 as reserved 0b.
- Direction Encodings (=C2=A7 4.2.18.1.2): Enforces that Left/Right and Up/=
Down
  direction bits remain 0b for symmetric receivers (Bits 6 & 7 reserved 0b)=
.
- Multi-Receiver Concurrency (=C2=A7 4.2.18.2): Governed strictly by MIndEr=
rorSampler.
  If MIndErrorSampler =3D=3D 0b (main data sampler), at most one receiver a=
cross the
  link is margined at a time.
- Autonomous Speed & Width Transitions (=C2=A7 7.5.3.7, =C2=A7 7.5.3.17, =
=C2=A7 8.4.4): Software
  sequencing disables Downstream Component before Upstream Component on ena=
blement,
  and restores Upstream Component before Downstream Component on teardown.
  Restoration is unconditional via pcie_capability_clear_and_set_word()
  (serialized by pci_lock), eliminating trylock failure traps.

Ingress paths (margin_enable_write and pci_lmr_exit) strictly follow the ca=
nonical
PCI locking DAG:
  down_read(&pci_bus_sem)
    -> pci_dev_lock(downstream_port)
      -> pci_dev_lock(upstream_port)
        -> mutex_lock(&mdev->lock)
          -> spin_lock_irqsave(&aspm_lock)

Key Concurrency Guarantees:
1. Hot-Swap Identity Invariance: When disabling LMR, dynamic endpoint resol=
ution
   is completely bypassed. Teardown binds strictly to the session-saved mde=
v->partner,
   which is read and pinned with pci_dev_get() under mutex_lock(&mdev->lock=
).
2. Surprise Removal & Fault Hardening: Hardware register accesses check
   pci_dev_is_disconnected() and PCI_POSSIBLE_ERROR() guards, preventing MM=
IO
   or config space bus aborts when hardware is pulled.
3. Power Management Synchronization: Both link partners are pinned in D0 us=
ing
   pm_runtime_resume_and_get() during enablement, and symmetrically release=
d via
   pm_runtime_put() on teardown. System suspend hooks into pci_pm_prepare()=
 where
   all devices in the hierarchy are guaranteed to be in D0.
4. Security Teardown Order: In pci_destroy_dev(), pci_lmr_exit() is called =
after
   pci_tsm_destroy(), preserving D0 state for TSM link operations (PCIe IDE=
 unbind
   and SPDM cryptographic session teardown).

- Build: Clean compile on x86_64 and ARM64; make W=3D1 drivers/pci/ (0 warn=
ings).
- Linters: checkpatch.pl clean across all 3 patches (0 errors, 0 warnings).
- Kselftest: tools/testing/selftests/pcie_lmt/pcie_lmt.sh expanded to 287 l=
ines,
  covering positive and negative boundary tests (syntax clean with bash -n)=
.
- Pre-Commit AI Review (Sashiko AI):
  * Patch 1 (f34fdf7f5c6b): Reviewed =E2=80=94 Clean (0 issues).
  * Patch 2 (6adc680a727f): Reviewed =E2=80=94 Clean (0 issues).
  * Patch 3 (c62b5f92af63): Reviewed =E2=80=94 Clean (0 issues, "No issues =
found.").

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v2:
- Decomposed monolithic LMR driver into a 3-patch stack with dedicated core=
 helpers:
  * Patch 1: PCI core link endpoint discovery helper (pcie_get_link_endpoin=
ts()).
  * Patch 2: Core ASPM temporary inhibition helper (pci_aspm_inhibit()).
  * Patch 3: PCIe Lane Margining at Receiver driver and debugfs interface.
- Core Scope Discipline: Confined LMR logic exclusively to drivers/pci/pcie=
/margin.c
  and include/linux/pci.h forward declarations (0 modified lines in pci.c/p=
ci-driver.c).
- Endpoint Discovery Hardening:
  * Handled RCiEP and empty downstream buses returning -ENODEV.
  * Added Function 0 resolution (pcie_find_link_upstream_func0()) supportin=
g PCIe ARI.
  * Added bridge ownership verification (child->self =3D=3D pdev) to preven=
t ABA races.
  * Added symmetric pcie_put_link_endpoints() to balance pci_dev_get() refe=
rences.
- ASPM Inhibit Hardening:
  * Added lockdep_assert_held_read(&pci_bus_sem) to pci_aspm_inhibit_locked=
().
  * Added reference counting (aspm_inhibit_cnt) to support nested/concurren=
t calls.
- Hot-Swap & Concurrency Protections:
  * Eliminated hot-swap identity mismatch in margin_enable_write() by bindi=
ng teardown
    strictly to session-saved mdev->partner instead of re-evaluating endpoi=
nts.
  * Added mutex protection when reading and pinning mdev->partner to elimin=
ate UAF races.
  * Converted autonomous speed/width restoration to unconditional register =
write via
    pcie_capability_clear_and_set_word(), eliminating trylock failure degra=
dation.
- Specification Alignments (PCIe Base Spec r7.0):
  * Aligned Extended Capability ID 0x27 to =C2=A7 7.7.11 and =C2=A7 8.4.4.
  * Enforced Function 0 restriction on Endpoints / Upstream Ports (=C2=A7 7=
.7.11).
  * Preserved Reserved Bits 7:5 in Command 88h capabilities response.
  * Implemented MIndErrorSampler-based concurrency for multi-receiver links=
 (=C2=A7 4.2.18.2).
  * Corrected direction bit encoding to 0b for symmetric receivers (=C2=A7 =
4.2.18.1.2).
- Kselftest Overhaul:
  * Extended test coverage from 105 to 287 lines, adding comprehensive boun=
dary
    and negative validation tests.
- Link to v1: https://lore.kernel.org/r/20260831-pcie-link-endpoints-v1-1-3=
2c2fd893e9e@google.com
- Link to v7 (monolithic LMR): https://lore.kernel.org/linux-pci/20260828-p=
cie-lmt-v7-1-6012e9e0940a@google.com/

---
Priyank Rathod (3):
      PCI: Add pcie_get_link_endpoints() helper
      PCI/ASPM: Add pci_aspm_inhibit() helper for temporary link state supp=
ression
      PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

 Documentation/PCI/index.rst                  |    1 +
 Documentation/PCI/pcie-lmr.rst               |  174 +++
 MAINTAINERS                                  |    8 +
 drivers/pci/pci.c                            |  152 +++
 drivers/pci/pci.h                            |    8 +
 drivers/pci/pcie/Kconfig                     |   12 +
 drivers/pci/pcie/Makefile                    |    1 +
 drivers/pci/pcie/aspm.c                      |  100 ++
 drivers/pci/pcie/margin.c                    | 1592 ++++++++++++++++++++++=
++++
 drivers/pci/probe.c                          |    1 +
 drivers/pci/remove.c                         |    2 +-
 include/linux/pci.h                          |   17 +
 include/uapi/linux/pci_regs.h                |   18 +
 tools/testing/selftests/Makefile             |    1 +
 tools/testing/selftests/pcie_lmt/Makefile    |    3 +
 tools/testing/selftests/pcie_lmt/pcie_lmt.sh |  287 +++++
 16 files changed, 2376 insertions(+), 1 deletion(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-pcie-link-endpoints-978e100d5d06

Best regards,
--=20
Priyank Rathod <rathodpriyank@google.com>

