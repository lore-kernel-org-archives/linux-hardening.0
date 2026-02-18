Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A9343D66
	for <linux-hardening@vger.kernel.org>; Wed, 18 Feb 2026 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430328; cv=pass; b=q7fVRYUQcZEp1tOp3x6sCLcp3lpBNUspKV0ZukyD26NOMZaODes52rbtxUZS3LmKZAEIkrtPvew+TZLEr6aXcHxiNTm4Wi6BthHI3TMU8T4rGeUX85gb0XpIF+RZzrL6DKrTYWTsKkrWeqOaT+i5grkW6BLBJcldOobk6V3UwoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430328; c=relaxed/simple;
	bh=VvEIHm0CVh76Y0ezSpIJTHt78UdN0D6dnlpEX+o5yqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYwBu1KdyfsdyKQoLEWhST1f2ths2Nkhlwl7PT4VnTj3KhsiOsplPedsdRxcrhlS27Lqka6DlNUTM42Vp+P0BstzCtk/IL/6VVu/vEaBv0SpabDZjH9zhsX6RI1ptjXx0CovfRGfUXZptADk8UtpDU4ptyB8IfErpiEhwbi9nxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLKyhgsm; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLKyhgsm"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c46d4a02ff5so385614a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Feb 2026 07:58:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771430325; cv=none;
        d=google.com; s=arc-20240605;
        b=HzC0V+5xx1u/Vn51SN0P04tZ3HG51OhEV8P6FFqzLoq5OoSR5/zEUT/wuZBBl0KPce
         jHXrYbgdlHbENSjD3tiwjfiAc/37eBUF1XheZ2A5qwvSVx++5oOWDqQdjuvUngdHAEG+
         KGrAhvB/SDPoioCsjKTeDGXzOBDdKmq+yaigEVIMVhz89aOrCVO5eB0okbOs9VpJ4E9f
         iatmgXxBCbgdYEbfjO41c/FC6OOG27SPlmro6DvrsW1bRcqN/ms7/Eid9E6JOT/LmkpS
         vs8yjeXn6Fu4lFKImtyaU8H7Z9q/XvMRaQBtfWijpM0atfA68fpqzURRjsBHkruNaiuv
         IHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+jEZRhKDKJOk8SBTSDYiUNsfqMbSOB+ljt4JuK9uCrE=;
        fh=y43VkuusqXqG1LfRwWBCRo2oAig8ETmwOsNjkxJjxvc=;
        b=TbbT9EvkC0i74o7LG5PpBKxCvOedZlURFHO26BhbB921hhuP4Y2t0/axAmNQivWlWF
         DBj2kBtf6MhBPFokQdrs8EryAPNU2xSNnNHFqzWsuLOBFPpdF+/uAyXvWnXUpx+o/HXT
         V9f5/aYfWf5ulnkiAVuL/ZWZO5NF+RvwILTgTvOotzyTKqr5fB+NpwbouGD67uFIo8PW
         jqkcDkujvQjtsBMH1Jf6XjZuvTGeeM8BqbQUDPUUWiAvzjdi1mpU2gQujlIuQ5l/HOOR
         /WVWJZk52sujcfpo0MdeGTtfm3x0oKhxZkdNGZYosNhqGxYKjqww9YyzHvAkVLkC2V1K
         tMWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771430325; x=1772035125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jEZRhKDKJOk8SBTSDYiUNsfqMbSOB+ljt4JuK9uCrE=;
        b=hLKyhgsmU3C00LOD59FISoEb9gpmq+xcs3mUTJWIMKiyrDupI2P5CllTFwCUebeEao
         KvRKb0YuUvnMCwcIVyZfgb5SouImFffixR3tidO/iBRrsRPgGAjgtawoD22w/MuJnmDe
         g6p2mjsdomLEzKaWo2Uo0QutEfVg0BVBP5LNxSuBVafgMjldf4r7L6zcmuxrYNJieh5s
         k6Hxx4tj4L25HET5rzypilxHi7CCDdUprpY/l5QY6FucbRiATtwqc6tqglrMk79rOMtg
         6P/LwjCvkwNKedBYv4AH5dUMR9oRhkeMxpSlMZ33OW5J93SKa7blc3gfoYbwKGOIe0Jx
         0cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430325; x=1772035125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+jEZRhKDKJOk8SBTSDYiUNsfqMbSOB+ljt4JuK9uCrE=;
        b=TocKZKEUMqEnfEhaV1mh+oT+PyEnY/09fiFvK9E7iG7j2/VS/A2yt56yQzkMrjFYZH
         lczTywwJ2c8WMvnGVQkun/jmabWIa64YHvDpFK0z03RyJTUqjkc1GeoJfixqAjieLDhv
         U4qYdB4Q8eu1JhKIyQcVsI2xznnoaIpg408iWPZCii/iJvXWXzoZxq64qncCuvdJyy7w
         9Otu17Yz1JhOZ2vG0HUbvhBCPGsHaQnK/vEV1wVMMn7XJXhFD+v301wtpVNLUHrG+EAU
         bEYQWrjJHM4Y/plvPaalpp5IN6ahTA+sqNLEyuA5BdUL10rZCqq6guZE+jCjhAZ6yki5
         HjkA==
X-Forwarded-Encrypted: i=1; AJvYcCX3BzwqHC1ZalYDlyEV39s/AN/W8J9evLKbyg1tL9eWhbpmoiLe3Y3LPdURJ15+dITksNCEL+yWXpetX3dWGPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7lYI1w09KBbglXeSeFe7E4schBZhdVDfV52tBItPUxYtUGej
	GN6tyWYC/AFhf/PrRrAKYlvMKiFmmGrDyI01ohcXTSwNR1/siQ99868YcZase4unOVZ9/bDo0c/
	wZxqBomL1SxpJVKkCmR6gZifslaRfSD4=
X-Gm-Gg: AZuq6aJKsh/YOykbCGti0WkQ7E5FMIDr511BWIU27qio2wbU3VrtW5B0uyxfbBvyGF0
	gDoCyNlsfdKugtr34BV0xQnpA6vs77hpHzQS1kWM7JNcrTs9gMfkVGv6fzE6emeKUoMJ7XMpYAK
	P6oy07CSR5yPMJ/ATn2VkOkqsl+L/XQb4LSyPSR8YfIit8S4tgHWjy8S+gVz9EtdFAhd/sceD+G
	LHkz7li6tQBx/8wJADr9MsSasBt+oCXrq/w23yHJVXf0H8l7Yd07std4p5+q7VKcFJI1xWfNNNK
	9QNBqY8=
X-Received: by 2002:a17:90b:28c4:b0:340:bca2:cf82 with SMTP id
 98e67ed59e1d1-356a7a44588mr12483278a91.4.1771430325136; Wed, 18 Feb 2026
 07:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
 <CACSVV00iiAXGOqV2HZs9KREoqatE0eNBZjFH9hSFMmNaX3_RXw@mail.gmail.com>
 <CACu1E7Fh=GbLTiedj6OqtUxWiZbCVcKmsEzV6FYan5G6r1uyUA@mail.gmail.com> <c99beabf-9841-44cd-9450-2f339d1d5c41@oss.qualcomm.com>
In-Reply-To: <c99beabf-9841-44cd-9450-2f339d1d5c41@oss.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 18 Feb 2026 10:58:33 -0500
X-Gm-Features: AaiRm51N5SpqVVJUQBLh2elCdDaV2cuIU7D7DKaGqf9-QJjihmDNYzh8f93hCZk
Message-ID: <CACu1E7EnveTSzi2QD83xEgsqrM1H33KCqMqcaLE-VebgOMbh0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Retrieve information about DDR from SMEM
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: rob.clark@oss.qualcomm.com, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Sean Paul <sean@poorly.run>, 
	Akhil P Oommen <akhilpo@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 6:23=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 1/9/26 10:03 PM, Connor Abbott wrote:
> > On Fri, Jan 9, 2026 at 3:41=E2=80=AFPM Rob Clark <rob.clark@oss.qualcom=
m.com> wrote:
> >>
> >> On Fri, Jan 9, 2026 at 11:11=E2=80=AFAM Connor Abbott <cwabbott0@gmail=
.com> wrote:
> >>>
> >>> On Thu, Jan 8, 2026 at 9:22=E2=80=AFAM Konrad Dybcio <konradybcio@ker=
nel.org> wrote:
> >>>>
> >>>> SMEM allows the OS to retrieve information about the DDR memory.
> >>>> Among that information, is a semi-magic value called 'HBB', or Highe=
st
> >>>> Bank address Bit, which multimedia drivers (for hardware like Adreno
> >>>> and MDSS) must retrieve in order to program the IP blocks correctly.
> >>>>
> >>>> This series introduces an API to retrieve that value, uses it in the
> >>>> aforementioned programming sequences and exposes available DDR
> >>>> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> >>>> information can be exposed in the future, as needed.
> >>>>
> >>>> Patch 3 should really be merged after 1&2
> >>>
> >>> No. The HBB value currently returned by the bootloader is *not* alway=
s
> >>> the same as what we use currently, because some SoCs (like SM8250)
> >>> with the same DT ship with multiple different DRAM configurations and
> >>> we've been using a sub-optimal value the whole time. After all, that'=
s
> >>> the whole point of using the bootloader value. But patches 1&2 will
> >>> only make the DPU use the bootloader value for HBB, not the GPU. So o=
n
> >>> one of the affected SoCs, it will introduce a mismatch. You can't
> >>> change anything until the GPU side uses the new ubwc config as its
> >>> source of truth.
> >>
> >> Hmm, how is this even working today if DPU is using HBB from the
> >> global table but GPU is not?  Are we just getting lucky with
> >> compositors that don't know about modifiers and end up scanning out
> >> linear?
> >
> > It works out as well as it's always worked out, i.e. we try to make
> > GPU and DPU config match and pray that we didn't mess it up. At least
> > now we'll get a warning when they don't match.
> >
> >>
> >> We do log warnings when the global ubwc config does not match the
> >> "fixed up" config.. google search for those msgs doesn't seem to turn
> >> up anything other than the patch which introduced them.  Idk if that
> >> is conclusive in any way, but I hope that means we could just delete
> >> the fixup code on the GPU side.  I suppose we could add:
> >>
> >>        *cfg =3D *common_cfg;
> >>
> >> after the warning as a first step.  That would maybe get some bug
> >> reports along with enough details in dmesg?
> >
> > Yes, the plan was always to delete the fixup code in the GPU config.
> > And even that first step would be enough to prevent regressions when
> > switching to the bootloader HBB value.
> >
> > There is a problem in that ubwc_swizzle isn't as well tested. Older
> > parts supporting UBWC 1.0-3.0 partially or entirely ignore
> > ubwc_swizzle, because it wasn't configurable back then, but we rely on
> > it being set correctly in Mesa for VK_EXT_host_image_copy and sparse
> > textures. So if ubwc_swizzle is incorrect you probably wouldn't
> > notice, until you hit the HIC codepath in zink or some game using
> > sparse textures. I think we fixed up all the cases where it was
> > incorrectly set to 0x1 instead of 0x7, but it would be worth it to
> > check again.
>
> Just to double-check, is your expectation to just double-check the kernel
> settings, or would that require some intervention on the mesa side too?
>
> Konrad

Just to double-check the kernel, and I double-checked since then and
everything seems to be right.

Connor
