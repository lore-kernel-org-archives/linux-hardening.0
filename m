Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59442145B1B
	for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784581; cv=none; b=jY4843tLoipxxcE/1YeJ+NbipZL0OFBoKalKOId2htMSvhGxeDXNajzjRaE7udbzl8PPQjxPL+o7UFskEgRgtCKBKsMJSUD9i9AUqHpZ5+OFSTusVYcgQr4fZPtda5CRq4kj9h0mHxmCgxbyfTmLmK0hnglTQBHn/0cxtbl3VAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784581; c=relaxed/simple;
	bh=6kcwZ0NwB8bKfQ1O2KPxhKnNfxk5TxjZ32X+4i48Wi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfgXhkwggydCVE9b8//wKiy4EHzwBzR2qkJ3v4tjMuwNMuiPbgpRIj4TCDxlOzlSXwMRfihkRySEqX6PEwL6iJ+vTTjJfydWbiuYyIVWgfQqcNn+2bjX+e/688ArWDwY2t1qhKX60rQWaL0j+ayYgnqwg1IS+nw4W8MPnQVN020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4vI9ioH; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4vI9ioH"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so7506129276.1
        for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715784578; x=1716389378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3c/AGmmeNGxvdjanDFjCGGDSIlxKKj0kxQSW+uGFKY=;
        b=e4vI9ioHE4Kd9/+K1+5yCcQ+pldB/0Ph03oWBDrSeTGlmUGzlEVaKeP99X6YCX3eSj
         kkK0UEHYG9Q4bnnxhrJ1LZ4gMDHyVAUpcYhK4LEpLf/zduj224Bi4VfHdutBXGh83ZTS
         yTAi0jojrxkrvS9Z5si1IFqkOuVBEOYYLlALge4fi9mEjDaSfRPMy4gyOZe7wIrP+PHk
         EEpFM1OETiFGV6aSDiAfgRgXYjKx9Lo+X0/52Gim+gCoBq/CCcO46sO8jjRKHSdY+n4B
         WxbIMAzowqjQnB5ZS0BMGOls/12uHePqzxIIwMwf6QqG1iinojkOfMir3XmGAoKrc1io
         zfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715784578; x=1716389378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3c/AGmmeNGxvdjanDFjCGGDSIlxKKj0kxQSW+uGFKY=;
        b=blI86JtneT/hFXn6IkQ5+4RwjHGak7boKB7V8Rmzhb9FEewzpBotZTRw71c6tBszym
         7k0HaaIZ93G/+mSyqEYNJC+CfXniHYT8vOSMNgmal5h00Uv77boD3krEqULJW76qEne6
         5DH+Ojwygiqty7ztxruR25AuRuvy6+lB2YkxQjaKwY2TpZfyKiqgIaQlA3ie1+6y7GoN
         sqzyV3mYSKNUzsdgabxOz2HB+GEZeewZqVmI5aDvqmemLsJllBbv6wSpz2lHdCWPiuvg
         fv1RLeo4az4S0ENrGZxsrzMc9jZnXZqAd1NdmuJRuvnVHKBNncltHiYbkjEkaiQAdcEq
         2Thg==
X-Forwarded-Encrypted: i=1; AJvYcCWhv0qHn6hNPpN3b9zzu7sLqnnseWghKdL3MzrPttLibSr6kNJ0LcB5vQH+Bxg3vtbevMXhvc63+PNHsdGjM8jM2Rbc6zuDb4iZihfwNVxm
X-Gm-Message-State: AOJu0YxEQE3gHXq9rDv+h0nGM+bKogEbE6Yu2CLyBr7x+lEXKBXbiomr
	2YgPiyAX2aB4UxNlg8bdk3PdMInou0aCO0U2GtCRqknCLOJY//bGhYZGWjllo/fNORHY36wf/3t
	3zo328VBIq2nlhj4YMfrZGmCpq8mmWD4e2QNo
X-Google-Smtp-Source: AGHT+IGshnEVNJaMCfTBu/Q17yiXGTfS5vz32My62pfreD9JYPEUCVlggiOCa9jFdoBx5W1I7S8w2f4JUuxjThbb5CE=
X-Received: by 2002:a25:a226:0:b0:df1:cd00:b176 with SMTP id
 3f1490d57ef6-df1cd00b56amr2001084276.39.1715784577896; Wed, 15 May 2024
 07:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405151008.6ddd1aaf-oliver.sang@intel.com>
In-Reply-To: <202405151008.6ddd1aaf-oliver.sang@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 15 May 2024 14:49:25 +0000
Message-ID: <CAJuCfpGSHgDwbYY+zq+wW_HFvsjj0gpgj+cHODi=8saz9-hXug@mail.gmail.com>
Subject: Re: [linux-next:master] [mm/slab] 7bd230a266: WARNING:at_mm/util.c:#kvmalloc_node_noprof
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Randy Dunlap <rdunlap@infradead.org>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Benno Lossin <benno.lossin@proton.me>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>, Dennis Zhou <dennis@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, 
	Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 7:41=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> as we understand, this commit is not the root-cause of this WARNING. the =
WARNING
> just shows in another way by commit changes.
>
> 53ed0af496422959 7bd230a26648ac68ab3731ebbc4
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           6:6          -83%            :6     dmesg.RIP:kvmalloc_node
>            :6           33%           6:6     dmesg.RIP:kvmalloc_node_nop=
rof
>           6:6          -83%            :6     dmesg.WARNING:at_mm/util.c:=
#kvmalloc_node
>            :6           33%           6:6     dmesg.WARNING:at_mm/util.c:=
#kvmalloc_node_noprof
>
>
> but we failed to bisect "dmesg.WARNING:at_mm/util.c:#kvmalloc_node".
>
> we still made this report FYI what we observed in our tests, not sure if =
it
> could give somebody some hints to find the real problem then judge if a f=
ix
> is needed.
>
> below is full report.
>
>
>
> kernel test robot noticed "WARNING:at_mm/util.c:#kvmalloc_node_noprof" on=
:
>
> commit: 7bd230a26648ac68ab3731ebbc449090f0ac6a37 ("mm/slab: enable slab a=
llocation tagging for kmalloc and friends")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 6ba6c795dc73c22ce2c86006f17c4aa802db2a6=
0]
>
> in testcase: igt
> version: igt-x86_64-86712f2ef-1_20240511
> with following parameters:
>
>         group: gem_exec_reloc
>
>
>
> compiler: gcc-13
> test machine: 20 threads 1 sockets (Commet Lake) with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202405151008.6ddd1aaf-oliver.san=
g@intel.com
>
>
> [  940.101700][ T5353] ------------[ cut here ]------------
> [ 940.107107][ T5353] WARNING: CPU: 1 PID: 5353 at mm/util.c:649 kvmalloc=
_node_noprof (mm/util.c:649 (discriminator 1))
> [  940.116178][ T5353] Modules linked in: netconsole btrfs blake2b_generi=
c xor zstd_compress intel_rapl_msr intel_rapl_common intel_uncore_frequency=
 intel_uncore_frequency_common raid6_pq libcrc32c x86_pkg_temp_thermal inte=
l_powerclamp coretemp kvm_intel sd_mod t10_pi crc64_rocksoft_generic crc64_=
rocksoft ipmi_devintf crc64 sg ipmi_msghandler kvm crct10dif_pclmul crc32_p=
clmul crc32c_intel ghash_clmulni_intel i915 sha512_ssse3 sdhci_pci drm_budd=
y cqhci ahci rapl intel_gtt drm_display_helper sdhci libahci mei_me ttm int=
el_cstate i2c_designware_platform ppdev intel_uncore intel_wmi_thunderbolt =
wmi_bmof libata mei i2c_designware_core idma64 drm_kms_helper mmc_core i2c_=
i801 i2c_smbus intel_pch_thermal parport_pc video parport pinctrl_cannonlak=
e wmi acpi_pad acpi_tad serio_raw binfmt_misc drm fuse loop dm_mod ip_table=
s
> [  940.188041][ T5353] CPU: 1 PID: 5353 Comm: gem_exec_reloc Not tainted =
6.9.0-rc4-00085-g7bd230a26648 #1
> [ 940.197459][ T5353] RIP: 0010:kvmalloc_node_noprof (mm/util.c:649 (disc=
riminator 1))
> [ 940.203412][ T5353] Code: 04 a3 0d 00 48 83 c4 18 48 83 c4 08 5b 5d 41 =
5c 41 5d 41 5e c3 cc cc cc cc 49 be 00 00 00 00 00 20 00 00 eb 9f 80 e7 20 =
75 de <0f> 0b eb da 48 c7 c7 10 ec af 84 e8 0e a6 18 00 e9 3f ff ff ff 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   04 a3                   add    $0xa3,%al
>    2:   0d 00 48 83 c4          or     $0xc4834800,%eax
>    7:   18 48 83                sbb    %cl,-0x7d(%rax)
>    a:   c4                      (bad)
>    b:   08 5b 5d                or     %bl,0x5d(%rbx)
>    e:   41 5c                   pop    %r12
>   10:   41 5d                   pop    %r13
>   12:   41 5e                   pop    %r14
>   14:   c3                      retq
>   15:   cc                      int3
>   16:   cc                      int3
>   17:   cc                      int3
>   18:   cc                      int3
>   19:   49 be 00 00 00 00 00    movabs $0x200000000000,%r14
>   20:   20 00 00
>   23:   eb 9f                   jmp    0xffffffffffffffc4
>   25:   80 e7 20                and    $0x20,%bh
>   28:   75 de                   jne    0x8
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   eb da                   jmp    0x8
>   2e:   48 c7 c7 10 ec af 84    mov    $0xffffffff84afec10,%rdi
>   35:   e8 0e a6 18 00          callq  0x18a648
>   3a:   e9 3f ff ff ff          jmpq   0xffffffffffffff7e
>   3f:   48                      rex.W
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 0b                   ud2
>    2:   eb da                   jmp    0xffffffffffffffde
>    4:   48 c7 c7 10 ec af 84    mov    $0xffffffff84afec10,%rdi
>    b:   e8 0e a6 18 00          callq  0x18a61e
>   10:   e9 3f ff ff ff          jmpq   0xffffffffffffff54
>   15:   48                      rex.W
> [  940.222971][ T5353] RSP: 0018:ffffc90000b576f8 EFLAGS: 00010246
> [  940.228978][ T5353] RAX: 0000000000000000 RBX: 00000000000000c0 RCX: 0=
000000000000013
> [  940.236885][ T5353] RDX: 000000000007ffff RSI: 0000000080000000 RDI: 0=
000000000000000
> [  940.244792][ T5353] RBP: 0000000080000000 R08: 0000000000000001 R09: 0=
000000000000000
> [  940.252700][ T5353] R10: ffffc90000b576f8 R11: 0000000000000000 R12: 0=
0000000ffffffff
> [  940.260626][ T5353] R13: 0000000000000000 R14: 0000000004000000 R15: f=
fffc90000b579a8
> [  940.268566][ T5353] FS:  00007f2043c5e8c0(0000) GS:ffff8883ee080000(00=
00) knlGS:0000000000000000
> [  940.277455][ T5353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  940.283988][ T5353] CR2: 00007f2043b5d000 CR3: 000000022f74a002 CR4: 0=
0000000003706f0
> [  940.291922][ T5353] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [  940.299872][ T5353] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [  940.307791][ T5353] Call Trace:
> [  940.311021][ T5353]  <TASK>
> [ 940.313926][ T5353] ? __warn (kernel/panic.c:694)
> [ 940.317930][ T5353] ? kvmalloc_node_noprof (mm/util.c:649 (discriminato=
r 1))
> [ 940.323187][ T5353] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> [ 940.327596][ T5353] ? handle_bug (arch/x86/kernel/traps.c:239 (discrimi=
nator 1))
> [ 940.331835][ T5353] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (disc=
riminator 1))
> [ 940.336419][ T5353] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry=
.h:621)
> [ 940.341348][ T5353] ? kvmalloc_node_noprof (mm/util.c:649 (discriminato=
r 1))
> [ 940.346602][ T5353] ? kvmalloc_node_noprof (mm/util.c:640)
> [ 940.351795][ T5353] eb_copy_relocations (drivers/gpu/drm/i915/gem/i915_=
gem_execbuffer.c:1685) i915
> [ 940.357636][ T5353] eb_relocate_parse_slow (drivers/gpu/drm/i915/gem/i9=
15_gem_execbuffer.c:1815) i915
> [ 940.363616][ T5353] i915_gem_do_execbuffer (drivers/gpu/drm/i915/gem/i9=
15_gem_execbuffer.c:1960 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:346=
6) i915
> [ 940.369790][ T5353] ? unwind_get_return_address (arch/x86/kernel/unwind=
_orc.c:369 (discriminator 1))
> [ 940.375305][ T5353] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
> [ 940.380084][ T5353] ? __pfx_i915_gem_do_execbuffer (drivers/gpu/drm/i91=
5/gem/i915_gem_execbuffer.c:3359) i915
> [ 940.386673][ T5353] ? kasan_save_track (arch/x86/include/asm/current.h:=
49 (discriminator 1) mm/kasan/common.c:60 (discriminator 1) mm/kasan/common=
.c:69 (discriminator 1))
> [ 940.391449][ T5353] ? __kasan_kmalloc (mm/kasan/common.c:370 mm/kasan/c=
ommon.c:387)
> [ 940.396121][ T5353] ? __pfx___might_resched (kernel/sched/core.c:10152)
> [ 940.401339][ T5353] ? check_heap_object (arch/x86/include/asm/bitops.h:=
206 (discriminator 1) arch/x86/include/asm/bitops.h:238 (discriminator 1) i=
nclude/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) i=
nclude/linux/page-flags.h:527 (discriminator 1) mm/usercopy.c:194 (discrimi=
nator 1))
> [ 940.406359][ T5353] i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/ge=
m/i915_gem_execbuffer.c:3612) i915
> [ 940.412769][ T5353] ? __pfx_i915_gem_execbuffer2_ioctl (drivers/gpu/drm=
/i915/gem/i915_gem_execbuffer.c:3572) i915
> [ 940.419658][ T5353] drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:744) =
drm
> [ 940.425039][ T5353] ? __pfx_drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl=
.c:729) drm
> [ 940.430914][ T5353] drm_ioctl (drivers/gpu/drm/drm_ioctl.c:842) drm
> [ 940.435660][ T5353] ? __pfx_i915_gem_execbuffer2_ioctl (drivers/gpu/drm=
/i915/gem/i915_gem_execbuffer.c:3572) i915
> [ 940.442610][ T5353] ? __pfx_drm_ioctl (drivers/gpu/drm/drm_ioctl.c:763)=
 drm
> [ 940.447822][ T5353] ? __fget_light (include/linux/atomic/atomic-arch-fa=
llback.h:479 (discriminator 2) include/linux/atomic/atomic-instrumented.h:5=
0 (discriminator 2) fs/file.c:1145 (discriminator 2))
> [ 940.452318][ T5353] __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:904 fs/io=
ctl.c:890 fs/ioctl.c:890)
> [ 940.457008][ T5353] do_syscall_64 (arch/x86/entry/common.c:52 (discrimi=
nator 1) arch/x86/entry/common.c:83 (discriminator 1))
> [ 940.461440][ T5353] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entr=
y_64.S:130)
> [  940.467236][ T5353] RIP: 0033:0x7f2046007c5b
> [ 940.471588][ T5353] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 =
24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   00 48 89                add    %cl,-0x77(%rax)
>    3:   44 24 18                rex.R and $0x18,%al
>    6:   31 c0                   xor    %eax,%eax
>    8:   48 8d 44 24 60          lea    0x60(%rsp),%rax
>    d:   c7 04 24 10 00 00 00    movl   $0x10,(%rsp)
>   14:   48 89 44 24 08          mov    %rax,0x8(%rsp)
>   19:   48 8d 44 24 20          lea    0x20(%rsp),%rax
>   1e:   48 89 44 24 10          mov    %rax,0x10(%rsp)
>   23:   b8 10 00 00 00          mov    $0x10,%eax
>   28:   0f 05                   syscall
>   2a:*  89 c2                   mov    %eax,%edx                <-- trapp=
ing instruction
>   2c:   3d 00 f0 ff ff          cmp    $0xfffff000,%eax
>   31:   77 1c                   ja     0x4f
>   33:   48 8b 44 24 18          mov    0x18(%rsp),%rax
>   38:   64                      fs
>   39:   48                      rex.W
>   3a:   2b                      .byte 0x2b
>   3b:   04 25                   add    $0x25,%al
>   3d:   28 00                   sub    %al,(%rax)
>         ...
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   89 c2                   mov    %eax,%edx
>    2:   3d 00 f0 ff ff          cmp    $0xfffff000,%eax
>    7:   77 1c                   ja     0x25
>    9:   48 8b 44 24 18          mov    0x18(%rsp),%rax
>    e:   64                      fs
>    f:   48                      rex.W
>   10:   2b                      .byte 0x2b
>   11:   04 25                   add    $0x25,%al
>   13:   28 00                   sub    %al,(%rax)
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240515/202405151008.6ddd1aaf-ol=
iver.sang@intel.com
>

Looks like the calculation inside eb_copy_relocations() here:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/i915/gem/i91=
5_gem_execbuffer.c#L1682
results in (size > INT_MAX) warning being triggered inside
kvmalloc_array(). Seems like the relocation count is too high for some
reason. I doubt it's our patch causing this but I'll try to reproduce
once I'm back from the conference.
Thanks,
Suren.

>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
