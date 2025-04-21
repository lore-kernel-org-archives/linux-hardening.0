Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81528FF;
	Mon, 21 Apr 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745230973; cv=none; b=RAnfQTUIXTBURZAz/RuNXCbzKi/DR/Dqx4wXZac9jnsUBJR5oegKmmj/lxPSotnyWCu7TIwOWLnbO7DWTFCcspv1za7xV9eOC7CClrdfAD4bCSA8ylGm+PQGM0WVw01mEtqOxk1t/H7CMrOz9mi52NLkHOKGG8GUYydjf3NP9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745230973; c=relaxed/simple;
	bh=PPpvNVDFkjLlNX2mkzSJlHECVfAp8/dmDdjF03SB5O4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5tkbASgs5qUoPmfMIvGXndc7Dn4ezgQ4/9Jo04FJ6kVRN5n6wTvYCUq/SfqHBkWWpwC9lrKnZiY/g0BTOQ6rWPM7E3BeuRVRqMS+Uanqa0mVrMRu08IfSQ1uCXidpGjlzBRfwkUjVQZ4O4afVCmW+n+2AJNIqOHInsXr/amqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=atpcw4JP; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="atpcw4JP"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Zh1ds5c69z9sPv;
	Mon, 21 Apr 2025 12:22:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745230961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rimkjlkDlz7vaQYP1ECGqfbM8Xg+f28wGf3ZP85K81Q=;
	b=atpcw4JP28s2sBcrKqFoijrnm3F4cjjaaHPYe67WUIzOPfJZa5PydhdEhaqk4I7ZUJsemc
	RzZwaS6zBgLtgIUszXzYsaMkSnnagHF0MzaCaxiqrko3wBcpdu4JIhWNMcqTV6xSFGXqzu
	4EGBqOsjDWK4yTRARuvJbOy9utQJKMqb6lULhUY+5V8aiRO94EYYW9eg6ZUOpxNOAgcB1y
	oFq0hC+64Ie5SskdTkCqBY0LAGFqzguvwI1zP56NDs5f3g8bW9JPHi1dVFUbryF1NODBuO
	86VsSA8pVvwAj0ZFD/mU6qUOTDQL7FY8PF5mvB+BPUtKs8MScl/Jtg31cfRgAQ==
Date: Mon, 21 Apr 2025 12:22:39 +0200
From: Erhard Furtner <erhard_f@mailbox.org>
To: kunit-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: WARNING: CPU: 27 PID: 7051 at lib/math/int_log.c:63
 intlog2+0xaa/0xe0 at running int_log_kunit test (v6.15-rc1)
Message-ID: <20250421122239.4ae189d3@outsider.home>
In-Reply-To: <20250408200208.40f56431@outsider.home>
References: <20250408200208.40f56431@outsider.home>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-META: n7x3ukmqy7sfr15q6euk6p641higf1sa
X-MBO-RS-ID: 4907e770d9c85182f24

Greetings!

Still getting this warning in v6.15-rc3 at running running int_log_kunit te=
st, also with a 'GCC14 -O2'-built kernel:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4436 at lib/math/int_log.c:63 intlog2+0xd3/0x110
Modules linked in: int_log_kunit fortify_kunit kunit snd_hrtimer snd_seq sn=
d_seq_device fuse zram af_packet cfg80211 ccm algif_aead crypto_null des3_e=
de_x86_64 cbc des_generic libdes cmac md5 bnep bluetooth rfkill nls_iso8859=
_15 nls_cp437 vfat fat dm_crypt nhpoly1305_avx2 nhpoly1305 chacha_generic c=
hacha_x86_64 libchacha adiantum libpoly1305 algif_skcipher snd_hda_codec_re=
altek sg snd_hda_codec_generic snd_hda_scodec_component pkcs8_key_parser sn=
d_hda_codec_hdmi amd_atl amd64_edac nct6775 edac_mce_amd snd_hda_intel nct6=
775_core hwmon_vid radeon snd_intel_dspcfg snd_hda_codec video joydev uas u=
sb_storage snd_hwdep backlight input_leds snd_hda_core drm_suballoc_helper =
led_class i2c_algo_bit snd_pcm kvm_amd drm_ttm_helper snd_timer ttm snd drm=
_exec soundcore drm_display_helper k10temp hwmon wmi_bmof wmi gpio_amdpt ev=
dev gpio_generic button hid_generic usbhid hid efivarfs sha512_ssse3 sha256=
_ssse3 sha1_ssse3 sha1_generic aesni_intel gf128mul crypto_simd cryptd ccp =
xhci_pci xhci_hcd usbcore usb_common dm_mod
CPU: 1 UID: 0 PID: 4436 Comm: kunit_try_catch Tainted: G    B            N =
 6.15.0-rc3-Zen3 #11 PREEMPT=20
Tainted: [B]=3DBAD_PAGE, [N]=3DTEST
Hardware name: To Be Filled By O.E.M. B550M Pro4/B550M Pro4, BIOS L3.46 08/=
20/2024
RIP: 0010:intlog2+0xd3/0x110
Code: c1 e0 18 48 83 c4 08 89 d1 c1 e2 08 29 cb 01 d0 0f b7 db 0f af dd c1 =
eb 0f 01 d8 5b 5d 41 5c 31 d2 31 c9 31 ff e9 98 88 d7 fe <0f> 0b 31 c0 31 d=
2 31 c9 31 ff e9 89 88 d7 fe 89 44 24 04 e8 65 27
RSP: 0018:ffffc90000aafd38 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000531f548 RCX: 0000000000000000
RDX: 1ffffffff8353124 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff92000155fa9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc1a98920
R13: 0000000000000000 R14: ffff888112a96400 R15: ffffc90000aafe18
FS:  0000000000000000(0000) GS:ffff888820ed7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd26f0f000 CR3: 000000017a363000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 intlog2_test+0xcb/0x200 [int_log_kunit]
 ? intlog10_test+0x200/0x200 [int_log_kunit]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? ktime_get_ts64+0x7a/0x220
 kunit_try_run_case+0x199/0x2b0 [kunit]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? kunit_try_run_case_cleanup+0xe0/0xe0 [kunit]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_raw_spin_unlock+0x4f/0x220
 ? kunit_try_run_case_cleanup+0xe0/0xe0 [kunit]
 ? kunit_mem_assert_format+0x460/0x460 [kunit]
 kunit_generic_run_threadfn_adapter+0x7b/0xe0 [kunit]
 kthread+0x349/0x6c0
 ? kthread_is_per_cpu+0xd0/0xd0
 ? kthread_is_per_cpu+0xd0/0xd0
 ? kthread_is_per_cpu+0xd0/0xd0
 ret_from_fork+0x2b/0x70
 ? kthread_is_per_cpu+0xd0/0xd0
 ret_from_fork_asm+0x11/0x20
 </TASK>
---[ end trace 0000000000000000 ]---
        ok 1 Log base 2 of 0
        ok 2 Log base 2 of 1
        ok 3 Log base 2 of 2
        ok 4 Log base 2 of 3
        ok 5 Log base 2 of 4
        ok 6 Log base 2 of 8
        ok 7 Log base 2 of 16
        ok 8 Log base 2 of 32
        ok 9 Log base 2 of MAX
    # intlog2_test: pass:9 fail:0 skip:0 total:9
    ok 1 intlog2_test
        KTAP version 1
        # Subtest: intlog10_test
------------[ cut here ]------------
WARNING: CPU: 23 PID: 4454 at lib/math/int_log.c:120 intlog10+0xe2/0x110
Modules linked in: int_log_kunit fortify_kunit kunit snd_hrtimer snd_seq sn=
d_seq_device fuse zram af_packet cfg80211 ccm algif_aead crypto_null des3_e=
de_x86_64 cbc des_generic libdes cmac md5 bnep bluetooth rfkill nls_iso8859=
_15 nls_cp437 vfat fat dm_crypt nhpoly1305_avx2 nhpoly1305 chacha_generic c=
hacha_x86_64 libchacha adiantum libpoly1305 algif_skcipher snd_hda_codec_re=
altek sg snd_hda_codec_generic snd_hda_scodec_component pkcs8_key_parser sn=
d_hda_codec_hdmi amd_atl amd64_edac nct6775 edac_mce_amd snd_hda_intel nct6=
775_core hwmon_vid radeon snd_intel_dspcfg snd_hda_codec video joydev uas u=
sb_storage snd_hwdep backlight input_leds snd_hda_core drm_suballoc_helper =
led_class i2c_algo_bit snd_pcm kvm_amd drm_ttm_helper snd_timer ttm snd drm=
_exec soundcore drm_display_helper k10temp hwmon wmi_bmof wmi gpio_amdpt ev=
dev gpio_generic button hid_generic usbhid hid efivarfs sha512_ssse3 sha256=
_ssse3 sha1_ssse3 sha1_generic aesni_intel gf128mul crypto_simd cryptd ccp =
xhci_pci xhci_hcd usbcore usb_common dm_mod
CPU: 23 UID: 0 PID: 4454 Comm: kunit_try_catch Tainted: G    B   W        N=
  6.15.0-rc3-Zen3 #11 PREEMPT=20
Tainted: [B]=3DBAD_PAGE, [W]=3DWARN, [N]=3DTEST
Hardware name: To Be Filled By O.E.M. B550M Pro4/B550M Pro4, BIOS L3.46 08/=
20/2024
RIP: 0010:intlog10+0xe2/0x110
Code: db 41 01 c4 0f af dd c1 eb 0f 42 8d 04 23 5b 5d 48 69 c0 a1 26 88 26 =
41 5c 41 5d 48 c1 e8 1f 31 d2 31 c9 31 ff e9 79 87 d7 fe <0f> 0b 31 c0 31 d=
2 31 c9 31 ff e9 6a 87 d7 fe e8 4a 26 73 ff e9 73
RSP: 0018:ffffc90001da7d38 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000531f548 RCX: 0000000000000000
RDX: 1ffffffff83530d0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff920003b4fa9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc1a98680
R13: 0000000000000000 R14: ffff888112a96400 R15: ffffc90001da7e18
FS:  0000000000000000(0000) GS:ffff8888219d7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0454cf4590 CR3: 0000000152504000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 intlog10_test+0xcb/0x200 [int_log_kunit]
 ? _sub_I_65535_1+0x310/0x310 [led_class]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? ktime_get_ts64+0x7a/0x220
 kunit_try_run_case+0x199/0x2b0 [kunit]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? kunit_try_run_case_cleanup+0xe0/0xe0 [kunit]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_raw_spin_unlock+0x4f/0x220
 ? kunit_try_run_case_cleanup+0xe0/0xe0 [kunit]
 ? kunit_mem_assert_format+0x460/0x460 [kunit]
 kunit_generic_run_threadfn_adapter+0x7b/0xe0 [kunit]
 kthread+0x349/0x6c0
 ? kthread_is_per_cpu+0xd0/0xd0
 ? kthread_is_per_cpu+0xd0/0xd0
 ? kthread_is_per_cpu+0xd0/0xd0
 ret_from_fork+0x2b/0x70
 ? kthread_is_per_cpu+0xd0/0xd0
 ret_from_fork_asm+0x11/0x20
 </TASK>
---[ end trace 0000000000000000 ]---
        ok 1 Log base 10 of 0
        ok 2 Log base 10 of 1
        ok 3 Log base 10 of 6
        ok 4 Log base 10 of 10
        ok 5 Log base 10 of 100
        ok 6 Log base 10 of 1000
        ok 7 Log base 10 of 10000
        ok 8 Log base 10 of MAX
    # intlog10_test: pass:8 fail:0 skip:0 total:8
    ok 2 intlog10_test
# math-int_log: pass:2 fail:0 skip:0 total:2
# Totals: pass:17 fail:0 skip:0 total:17
ok 1 math-int_log


Regards,
Erhard

On Tue, 8 Apr 2025 20:02:08 +0200
Erhard Furtner <erhard_f@mailbox.org> wrote:

> Greetings!
>=20
> I gave v6.15-rc1 a test ride on my Ryzen 5950 system with some debugging =
options turned on.
>=20
> At running int_log_kunit I noticed the following WARNING in dmesg:
>=20
> [...]
> KTAP version 1
> 1..1
>     KTAP version 1
>     # Subtest: math-int_log
>     # module: int_log_kunit
>     1..2
>         KTAP version 1
>         # Subtest: intlog2_test
> ------------[ cut here ]------------
> WARNING: CPU: 27 PID: 7051 at lib/math/int_log.c:63 intlog2+0xaa/0xe0
> Modules linked in: int_log_kunit uinput rfcomm btusb btrtl btmtk btbcm bt=
intel fortify_kunit kunit snd_hrtimer snd_seq snd_seq_device fuse zram cfg8=
0211 af_packet ccm algif_aead crypto_null des3_ede_x86_64 cbc des_generic l=
ibdes cmac md5 bnep bluetooth rfkill nls_iso8859_15 nls_cp437 vfat fat dm_c=
rypt nhpoly1305_avx2 nhpoly1305 chacha_generic chacha_x86_64 libchacha adia=
ntum libpoly1305 algif_skcipher pkcs8_key_parser nct6775 hwmon_vid nct6775_=
core snd_hda_codec_realtek snd_hda_codec_generic uas usb_storage snd_hda_sc=
odec_component snd_hda_codec_hdmi amd_atl radeon amd64_edac snd_hda_intel e=
dac_mce_amd snd_intel_dspcfg snd_hda_codec drm_suballoc_helper snd_hwdep dr=
m_ttm_helper ttm snd_hda_core i2c_algo_bit video snd_pcm kvm_amd backlight =
drm_exec snd_timer drm_display_helper snd k10temp hwmon soundcore wmi_bmof =
gpio_amdpt wmi gpio_generic button input_leds joydev led_class evdev hid_ge=
neric usbhid hid efivarfs sha512_ssse3 sha256_ssse3 sha1_ssse3 sha1_generic=
 aesni_intel gf128mul crypto_simd cryptd ccp
>  xhci_pci xhci_hcd usbcore usb_common dm_mod
> CPU: 27 UID: 0 PID: 7051 Comm: kunit_try_catch Tainted: G    B           =
 N  6.15.0-rc1-Zen3 #6 PREEMPT=20
> Tainted: [B]=3DBAD_PAGE, [N]=3DTEST
> Hardware name: To Be Filled By O.E.M. B550M Pro4/B550M Pro4, BIOS L3.46 0=
8/20/2024
> RIP: 0010:intlog2+0xaa/0xe0
> Code: 29 c5 41 0f b7 cd 0f af d9 c1 eb 0f c1 e5 18 c1 e0 08 09 e8 01 d8 5=
b 41 5c 41 5d 41 5e 41 5f 5d 31 c9 31 ff e9 d2 60 1a ff cc <0f> 0b 31 c0 eb=
 e6 44 89 f1 80 e1 07 fe c1 38 c1 7c 9b 4c 89 f7 e8
> RSP: 0018:ffffc90000e1fda8 EFLAGS: 00010246
> RAX: 1ffffffff82fb400 RBX: ffffc9000c5cf630 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000208040 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffc90000e1fe40 R11: ffffffffc09fb000 R12: dffffc0000000000
> R13: 0000000000000000 R14: ffffffffc17da1a0 R15: ffffc90000e1fe30
> FS:  0000000000000000(0000) GS:ffff888835418000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f83bc35c000 CR3: 000000011287f000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  intlog2_test+0x6e/0x170 [int_log_kunit]
>  ? ktime_get_ts64+0x8f/0x1f0
>  kunit_try_run_case+0x119/0x340 [kunit]
>  ? kunit_cleanup+0x120/0x120 [kunit]
>  kunit_generic_run_threadfn_adapter+0x73/0x100 [kunit]
>  kthread+0x46a/0x570
>  ? kunit_try_catch_run+0x620/0x620 [kunit]
>  ? kthread_blkcg+0xb0/0xb0
>  ret_from_fork+0x3c/0x70
>  ? kthread_blkcg+0xb0/0xb0
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
> ---[ end trace 0000000000000000 ]---
>         ok 1 Log base 2 of 0
>         ok 2 Log base 2 of 1
>         ok 3 Log base 2 of 2
>         ok 4 Log base 2 of 3
>         ok 5 Log base 2 of 4
>         ok 6 Log base 2 of 8
>         ok 7 Log base 2 of 16
>         ok 8 Log base 2 of 32
>         ok 9 Log base 2 of MAX
>     # intlog2_test: pass:9 fail:0 skip:0 total:9
>     ok 1 intlog2_test
>         KTAP version 1
>         # Subtest: intlog10_test
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 7069 at lib/math/int_log.c:120 intlog10+0x1e/0x30
> Modules linked in: int_log_kunit uinput rfcomm btusb btrtl btmtk btbcm bt=
intel fortify_kunit kunit snd_hrtimer snd_seq snd_seq_device fuse zram cfg8=
0211 af_packet ccm algif_aead crypto_null des3_ede_x86_64 cbc des_generic l=
ibdes cmac md5 bnep bluetooth rfkill nls_iso8859_15 nls_cp437 vfat fat dm_c=
rypt nhpoly1305_avx2 nhpoly1305 chacha_generic chacha_x86_64 libchacha adia=
ntum libpoly1305 algif_skcipher pkcs8_key_parser nct6775 hwmon_vid nct6775_=
core snd_hda_codec_realtek snd_hda_codec_generic uas usb_storage snd_hda_sc=
odec_component snd_hda_codec_hdmi amd_atl radeon amd64_edac snd_hda_intel e=
dac_mce_amd snd_intel_dspcfg snd_hda_codec drm_suballoc_helper snd_hwdep dr=
m_ttm_helper ttm snd_hda_core i2c_algo_bit video snd_pcm kvm_amd backlight =
drm_exec snd_timer drm_display_helper snd k10temp hwmon soundcore wmi_bmof =
gpio_amdpt wmi gpio_generic button input_leds joydev led_class evdev hid_ge=
neric usbhid hid efivarfs sha512_ssse3 sha256_ssse3 sha1_ssse3 sha1_generic=
 aesni_intel gf128mul crypto_simd cryptd ccp
>  xhci_pci xhci_hcd usbcore usb_common dm_mod
> CPU: 1 UID: 0 PID: 7069 Comm: kunit_try_catch Tainted: G    B   W        =
N  6.15.0-rc1-Zen3 #6 PREEMPT=20
> Tainted: [B]=3DBAD_PAGE, [W]=3DWARN, [N]=3DTEST
> Hardware name: To Be Filled By O.E.M. B550M Pro4/B550M Pro4, BIOS L3.46 0=
8/20/2024
> RIP: 0010:intlog10+0x1e/0x30
> Code: f7 e8 96 89 92 ff eb 9f 0f 1f 40 00 85 ff 74 1a e8 17 ff ff ff 89 c=
0 48 69 c0 a1 26 88 26 48 c1 e8 1f 31 ff e9 7e 60 1a ff cc <0f> 0b 31 c0 eb=
 f2 cc cc cc cc cc cc cc cc cc cc cc cc 85 f6 74 2a
> RSP: 0018:ffffc90001c67dd8 EFLAGS: 00010246
> RAX: 1ffffffff82fb400 RBX: ffffc9000c5cf630 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000208040 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffc90001c67e40 R11: ffffffffc09fb1b0 R12: dffffc0000000000
> R13: 0000000000000000 R14: ffffffffc17da480 R15: ffffc90001c67e30
> FS:  0000000000000000(0000) GS:ffff888834718000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00003c7cb8987000 CR3: 0000000164e07000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  intlog10_test+0x6e/0x170 [int_log_kunit]
>  ? ktime_get_ts64+0x8f/0x1f0
>  kunit_try_run_case+0x119/0x340 [kunit]
>  ? kunit_cleanup+0x120/0x120 [kunit]
>  kunit_generic_run_threadfn_adapter+0x73/0x100 [kunit]
>  kthread+0x46a/0x570
>  ? kunit_try_catch_run+0x620/0x620 [kunit]
>  ? kthread_blkcg+0xb0/0xb0
>  ret_from_fork+0x3c/0x70
>  ? kthread_blkcg+0xb0/0xb0
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
> ---[ end trace 0000000000000000 ]---
>         ok 1 Log base 10 of 0
>         ok 2 Log base 10 of 1
>         ok 3 Log base 10 of 6
>         ok 4 Log base 10 of 10
>         ok 5 Log base 10 of 100
>         ok 6 Log base 10 of 1000
>         ok 7 Log base 10 of 10000
>         ok 8 Log base 10 of MAX
>     # intlog10_test: pass:8 fail:0 skip:0 total:8
>     ok 2 intlog10_test
> # math-int_log: pass:2 fail:0 skip:0 total:2
> # Totals: pass:17 fail:0 skip:0 total:17
> ok 1 math-int_log
>=20
>=20
> The test itself however seems to pass. Kernel .config attached.
