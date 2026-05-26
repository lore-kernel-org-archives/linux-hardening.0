Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BB3B5847
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812700; cv=pass; b=UlGSEjNVrpbGwBXYVrTDUsZeH5ErjXJMkVWY+Yt4DwgGWVf8lTsG4pOTQgzdETq6uN63nnh0tVNmAP+8cq2G3bkEw4MCnC0tSuQTWh91oBHXrJX1kn+YpPyQVi2M7WeKk9NoaXGY67g/YZLgagN7jqcfFoPqlpZHmj+GQ2Aw4KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812700; c=relaxed/simple;
	bh=wqD3bt6Kl6xYQ2OceSau18FGXwySTFWbI4PmzPjOUUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKYkIzGaSWfYCrwKNHaoEcEdOy0HoWDlvmOeSkVyKBJcmGTMx//a7qVim2K2MHuViVa/PWo67PXKR3moLHSrW8/TSXXfPv3/dJvLEJdOwwE9VhY4mO9RFKMYJsBJZ9pfuDEk730XyFyVLRLBKZHgFcNacSz40G/BD7AIJ05aNvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQR473VU; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQR473VU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45297094718so8357851f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 09:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779812697; cv=none;
        d=google.com; s=arc-20240605;
        b=CUqvUAHS54UUrmkWTlywm1vHcK27f5lngh4bUUZfsNKtNs55ynRFRKNZyT7VsgnY5I
         RsVSQK8AXwXXoYs/MT9Jv9of1Rdy6zkPMaCqzIrkNvMHcYunPJvm0Ht+cfeLmiw+inx4
         ffXcYqTkSL05rzr3mPvipyDmOBGynV07dG3HxCMzAslPq+5iXiaaXrSIk2Y8ooacIJf5
         eJsiRXXfNLJ0RNp5OueXQhpWKf2mwzWF8phHcmHUyFZ1TbVtyCp1FgDYHvQiMZxqRPQP
         llGEHa9Agi84asO0z96kJZDlYcVMJBD+W17+muTNcnXenfnf3TZTo3rGUzpVdQAvFurE
         lKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4oammD2Vn2GS7tgFaMZOeQPZHe3j9rfMWe0E1YbLoz8=;
        fh=mfzmBSBylQBW0SxHQcyN8H832HXsucCn9z6NU2Gk/FA=;
        b=NO+5L6FxKw9289dzerPs+cGUUcuXZukoJlHezSeycDZD9RSXsjhX6vkDt6hFaSnfF1
         W+vrGWVDAc3FXx//ZYlQXYZlXxKyzw1XBE4adwizKWkNXoPKqD3Q/PF2WqfD/JD0zxg9
         YB4KI2UCaS5MjZxKnz+Xniav/WcOtCQb7ToihWWkxD8f6NyaZbFCHpU1m9asJ//1JoRb
         1IyyXkENPwCW6/Jw19aXxfSoWrTGaE683c06KBrAaQgnm9ogvIirE5n0x43OHg+gTS3/
         dTemvdNAziYk/ofEYz/4RaorpMvVcXnGer2yEX+U1xnV+vcgGXy3iV1NbWBls840YhiC
         rwxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779812697; x=1780417497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oammD2Vn2GS7tgFaMZOeQPZHe3j9rfMWe0E1YbLoz8=;
        b=PQR473VU+k2XTlDUwROgrUZIB1W0/ryGF9IkahAIVNFOEnc7PjIe/krRmrHFyNc1O6
         mnMjEvuF04PmtjfdCImJMk8gT8iUYJAq/kq/W2B/SZkRgPHO0c1ABjfqSXuu5oL+Qb9F
         xHG6D59WEd+NQ+R6f3THzkKx+B5f1xMDyj4jlj250lr1fATmFAwnEoOl2TADiZjjD6Y3
         TF1EQITDgVHILbsMlSyfZBowjvIpODweDZfpOrpNzeKf/XX42zCYJ/J7MiMonlOny5lW
         rHon1tkVoazKkFuho1vh4H04njZfdp3WlfVm2wPOGAiPLCe5eWQOlRRdj3bpmtyYiqfR
         LcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779812697; x=1780417497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4oammD2Vn2GS7tgFaMZOeQPZHe3j9rfMWe0E1YbLoz8=;
        b=k24MEEV8jWyXxtiFnlQSe4uegTRJjR1ie4XZW7zCNUQ3nAby7u7YDSLxzBF5O+iw07
         IwZqegl4F/3eyBSaFjGr9920IR2mRmX/7D8R79yupxtS1FNpyQ3b6GcC/Rx80DvhSbVi
         icT0yaTxeg32GgegM7eOuI0ZaP803HK4mZEjIo7InZL4CjqeW+wq68uM2L2n3eNlg8D3
         IYfwqOfH0Sm0g5+MeTN9RgsLPLj7SHGRUtDCMDCzqnjv2lnW1YA+6+aX4oZv/r/0y4zr
         EslKXNOaV+F/PoVWOvIMJbSeSfyuI7C1aEDbG41fCwrXsXvCkVbHK3IIoGaEZt6RX01P
         AGww==
X-Forwarded-Encrypted: i=1; AFNElJ/onja8JKKRTuS5V8tNza19RQ/2g3tC2krs5NCDQ3LPo99vTVk9mTZUsefytS98hcf1L3MdIVL0lvyLQuUnYzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLn7T6LXU3dgapYVQYTMREWENRRXZhzhqhDVvh0xHLEAHeFDde
	cp2olJzLaruxgPPTWLaVPsJPnS+Nx9jbxWPg2isq2tDfJQyr969Ybj9AiAs+9CZ5Y0/ZfRbIWn6
	1ggm8jJUCxW7n8kXWhAC45L9GrFt9voU=
X-Gm-Gg: Acq92OGjT9m+55dBORCgCQJXQmKZAs44MKvwHQ6r0NBGu6rjczbTqLLTkquLzN0yeFU
	LEEHGZtFGOIL0+jjH+ITk+ZYBYWlBJ/3TcKKNVRq2wgf2fPcb6KkpkShAkyhPH1pApKEx8o9lpP
	1gbZ0cK29HPANU82tlqilPZdvgQfvNsW4quymvldQWmVAjKISDTOPY69HqrjC9Z3kNTvvZJFVYt
	PGC6wfuZme1MHDwWw8IxjRSFNQwLq8l3NJholEaxVHvpW4dLgq/oTB3i2M3WNwfl7XCx7SyNwlf
	Ng37RZlMMtZfrFfAjCNzRh5gQS3QkWmgmMzE3d2ZfZxixZLMjkg8sTfX7whDY40WQ5g=
X-Received: by 2002:a5d:64e4:0:b0:449:c5e2:a8b7 with SMTP id
 ffacd0b85a97d-45eb38c19b5mr33050060f8f.30.1779812696769; Tue, 26 May 2026
 09:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
 <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com>
 <18c41409-e1d1-4877-87a6-1c3156f943aa@embeddedor.com> <CAMuHMdVznvSLr+ap3QwawZdu8fc4dZjpkWi7wgUA815KRfCgEQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVznvSLr+ap3QwawZdu8fc4dZjpkWi7wgUA815KRfCgEQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 26 May 2026 17:24:30 +0100
X-Gm-Features: AVHnY4K6-krW10j45FFrHmg7LOI21ztwu2LQ8TKbK1nF96GjbpuuFdl7Xhmc4k4
Message-ID: <CA+V-a8szZoKSb1SszB_0pGW+jU+8mUVJrL-uiTZ844DQ=ZB9qg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Wed, May 20, 2026 at 8:41=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Gustavo,
>
> On Tue, 19 May 2026 at 20:44, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > On 5/19/26 07:44, Lad, Prabhakar wrote:
> > > On Tue, May 19, 2026 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > >> On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >>>
> > >>> Fix an counter tracking in mmc_test_alloc_mem() that causes a kerne=
l panic
> > >>> during error unwinding.
> > >>>
> > >>> The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation o=
n its
> > >>> flexible array member `arr`. While kzalloc_flex() initially sets th=
e
> > >>> counter field (`cnt`) to `max_segs`, the allocation loop needs to t=
rack
> > >>> how many elements have actually been populated.
> > >>>
> > >>> Previously, leaving `mem->cnt` at `max_segs` meant that if the loop=
 failed
> > >>> midway (e.g., "Failed to map sg list"), the error unwinding path in
> > >>> mmc_test_free_mem() would attempt to clean up uninitialized trailin=
g
> > >>> array slots. This resulted in passing NULL pointers to __free_pages=
(),
> > >>> triggering a kernel panic:
> > >>>
> > >>>    [   66.172845] mmc0: Failed to map sg list
> > >>>    [   66.176722] Unable to handle kernel NULL pointer dereference =
at virtual address 0000000000000000
> > >>>    ...
> > >>>    [   66.432747] Call trace:
> > >>>    [   66.435191]  ___free_pages+0x1c/0xc4 (P)
> > >>>    [   66.439119]  __free_pages+0x14/0x20
> > >>>    [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
> > >>>
> > >>> Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> > >>> allocation. Then, move the existing `mem->cnt` increment so that it=
 occurs
> > >>> prior to populating each array slot, using `mem->cnt - 1` for the a=
ctual
> > >>> assignment index. This guarantees that the counter accurately track=
s
> > >>> initialized entries for safe error cleanup, while dynamically expan=
ding
> > >>> the `__counted_by` validation boundary ahead of each flexible array=
 write.
> > >>>
> > >>> Additionally, rewrite the cleanup loop in mmc_test_free_mem() to us=
e a
> > >>> standard forward for-loop. This addresses the unsafe post-decrement=
 logic
> > >>> in the original `while (mem->cnt--)` loop which evaluated and decre=
mented
> > >>> the counter field before indexing the array, and avoids a potential=
 integer
> > >>> underflow/wrap-around of the counter field if the cleanup path is i=
nvoked
> > >>> when `mem->cnt` is 0.
> > >>>
> > >>> Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > >>> ---
> > >>> v1->v2:
> > >>> - Started with cnt =3D 0 and incremented before assignment to ensur=
e
> > >>>    accurate tracking of initialized entries in mmc_test_alloc_mem()=
.
> > >>> - In mmc_test_free_mem(), replaced the while loop with a forward fo=
r-loop to
> > >>>    safely iterate over initialized entries without risking underflo=
w.
> > >>> - Updated commit message to clarify the issue and the fix.
> > >>
> > >> Thanks for your patch!
> > >>
> > >>> --- a/drivers/mmc/core/mmc_test.c
> > >>> +++ b/drivers/mmc/core/mmc_test.c
> > >>> @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_m=
em *mem)
> > >>>   {
> > >>>          if (!mem)
> > >>>                  return;
> > >>> -       while (mem->cnt--)
> > >>> -               __free_pages(mem->arr[mem->cnt].page,
> > >>> -                            mem->arr[mem->cnt].order);
> > >>> +       for (unsigned int i =3D 0; i < mem->cnt; i++)
> > >>> +               __free_pages(mem->arr[i].page, mem->arr[i].order);
> > >>>          kfree(mem);
> > >>>   }
> > >>>
> > >>> @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > >>>          mem =3D kzalloc_flex(*mem, arr, max_segs);
> > >>>          if (!mem)
> > >>>                  return NULL;
> > >>> +       mem->cnt =3D 0;
> > >>
> > >> This is not needed, as it is set to zero by kzalloc_flex().
> > >>
> > > Actually, kzalloc_flex() automatically sets mem->cnt to max_segs
> > > because cnt is annotated with __counted_by. Because of that implicit
> > > initialization, we need this explicit reset to get it back to zero.
> >
> > An auxiliary variable could be used to avoid having to update the
> > counter too early[1][2].
>
> Thank you!
> In light of this, Prabhakar's v1[3] is the better solution.
> But perhaps that the addition of "mem->cnt =3D max_segs;" after the
> kzalloc_flex() should be dropped, as it is done automatically by
> compilers that support __counted_by, but is irrelevant for compilers
> that do not support it (the correct value is set at the end anyway).
>
> Gustavo, what do you think?
>
Do you want me to send a v3 based on v1 [0] dropping  "mem->cnt =3D max_seg=
s;"?

[0] https://lore.kernel.org/all/20260513201315.3186621-1-prabhakar.mahadev-=
lad.rj@bp.renesas.com/


Cheers,
Prabhakar
