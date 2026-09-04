Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1119282F10
	for <linux-hardening@vger.kernel.org>; Fri,  4 Sep 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526962; cv=pass; b=Fi9e7irn7pGPnaWtRJ64nmopuPcLMBCdtxyB+BEbMX82j/SkgKq6qk4SOVeM4GG8LIrefPrjc2QW3LRdRDRbUUVAVIb6OrdWAr+wrZP5kfyN/ZVHc+nVrtqHceyulgPc9M8c2H7aT39Jx63GR2kmY0dRxpTCdaHkBtbJ4dDXd6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526962; c=relaxed/simple;
	bh=jA/Pi3dFWAvnVX/ST1pvVL4fyN3fIOOPQixPvnlSwNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDrk2369B2uxfZBtlqVhQHLdMg0KaJHZgnoBEVyEQrdgIZRLIehXDf1+nOJl8GEp6QS9Z79+hMPaqDUR2lPEHMmV1A4Ck5N7ZWxP7PTzTtyKIpIIEKrDJFCBFMZ3ORPZy25Yd47rc8w0UjMxiseksDe4mhr9V9VH4bKSK2s/7Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZnq5QdO; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZnq5QdO"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15e2dab83eso157628666b.1
        for <linux-hardening@vger.kernel.org>; Fri, 04 Sep 2026 06:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788526959; cv=none;
        d=google.com; s=arc-20260327;
        b=BJ0yRGA7ovDg0RnkxLUipILGlQa0rVLbC7a+PIMBGCfHsi9DBoZrskyCyueMtICvnT
         giAPv45g5PrE/HaNf4oLrjFONn+GVTPkG+y7r3v2DGR/mG+vf8GbKUwCzNc41IhJe50+
         aISTXxxen6eo6BTQR4DtWvFE9LKchCu5GszJV+fcVj458cBtXuOrb4VPqXJC4MJpyvJr
         KVye2TtV3ieGNJ3Awa0tXoxT7KPJAq2jkIJAW/uE3kv3b5PBBNpvc3mFrIVjqufjYJfB
         ds9AJ6DyanYD4FltdybvgX0ZuvCG7JUj6Kwwvt1vAxeuPJTT3CcWMqWmkyEw+EhYgZmK
         CcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1Y7YmZWSzxr2iY3IqKw6JuwDP6OUCGK+XiwHXOkRsQ=;
        fh=DRwHWIgD2IDlR3uf1pPZ7K687iyG1IlXbfO5Afu8aVI=;
        b=TLQnpdjZ6CDyqLyQP3turNxO+okOsPUfy+MY05mfZZEmp7UN9Ag9QMS6SZ1nvORdZc
         Jw2bYYvR9RfS13kLZnbndOs6H0HOWy4UgBUrtzdZRhID0XpH/fFC4ZkNl3sIw0ZDHHn6
         MTfZ7vwz+fO2rOgo8sHh8kC6hW49timiHF3icZ3Whi/ScRCE6ZtjxLw8t3Qz472kfWHO
         mBf2f6104RBXQUYdAqRNNyIzXoaJ34xfXKRKLdH4Hsa/ZBUszAMrXyHN/JlQsSXkdw4W
         HwWKuSqrKbb+k61XJP3pepJGOxd03qTVLSf/gmaP0tJ2ziBcSaDX3YoTaMf5LiNvk5xS
         lR+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788526959; x=1789131759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A1Y7YmZWSzxr2iY3IqKw6JuwDP6OUCGK+XiwHXOkRsQ=;
        b=JZnq5QdON4iMnuLMfH5/YNToHAXyXFwfD/iLJurxT6EWxtSi/4Jz8al77OPONCaGlC
         elPEVNw9XivYVVUUQbxqeY7UZ+8PmZD87YILUeDh76S8zTcRofBXgW2yHkC/efdr9aLq
         TFIJMdr1YMk4w6Vp2DJ4RRkJTzkwUd4+99ICxTjX829nQ3UUYIzixsIYqpS8g9xywwFy
         LDdoi9k+egyXmKhOun6h5PN/tezIe7c6asy62PM06SICEka89KHQa/D1UyQ7kf6oJ6em
         OAGNIOSCaJ9OVTewYsDD9pS9Q4jU6TG4JEu17c5ovy7FLY9ZpvPTW6WPZhT/zgf5cRob
         diiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788526959; x=1789131759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1Y7YmZWSzxr2iY3IqKw6JuwDP6OUCGK+XiwHXOkRsQ=;
        b=P8cOMY9CZP+HQs91ABYyOX0//pwYYgFXBS4zYwMJ3McwzrcnkOSfzVUr6SuDlzdY0K
         XrpiMKbMs5EZ1H6dzUQYCVtpcArf8R7Xk0i52ufRm29BqrG15QPPuk0EbBjC/Y8FXo5e
         gHOxIPL/01uVH0wzcPv/d5S4jL16e9MwFW+uZpKksbb+AV09VPBqqWT2YiNafzRrPYjj
         8qkoQMPJZ/htYMtFAPairmWSUErJeKRXKqChCjcbhnuNWq3BgOh89X5JW8AgQhd/lhfv
         GFp6CPr+uElSxp2/nz1Rk/vVsqDb0NIZVtLFBbwTjKYPUqjqllDbNG9ZSjhcLTALs0tO
         xiSA==
X-Forwarded-Encrypted: i=1; AKwUvBz+vYYAcBl0lvl+op+KCDZkPftcFYI6OfFRd9gHUAWlMWR2jex1LwrF0OwziuQ/pQaURCR8xNWXjNd+klWOW6o=@vger.kernel.org
X-Gm-Message-State: AFuF++lN4cqge3V9ArC5+Ar27LtDdJIprpEf32ww/FloPPMVRctBaHiG
	wtu63QXwrBXjpwZeWeIrI7zhBlIi581S9tVYAv+auT28L1JE+WLIEpiSW0/9/I3CWBKB6FZC95I
	Begn0hGnPXAJjhUNP8vypBqwX6i+JoRM=
X-Gm-Gg: AYBFou0oz8lTrheY0wzYNz97IZrPzaPN3vBEzHYwMMUnD1fb+XlrjCzp2OiMwIDhaIj
	qzsOdqyyMwaHK/3rLeW0Hc3AvuATXWiJ+M3BDDEA/tOZfLdtpVRCKeJWQsaREIRzUMSKNC0/cXi
	Tx2EVgRuyGnJpJRsyIPS60sO1mjLj5Zpwgmzi0//NaoNM1pAjmxYbI013pr0QOHW6gmrhRCOuA9
	6VD2dptClCpO3twcWhv9uG1w0aESmOXCUG04QjYE5eDx9T8mZWX7a+Dgb5e5Ru4IPxLoMkOk8K4
	9onCKZfcztCwH8ol53zdGnwaDYJOKjXrDwP8hL4kiCpAY0HDfyC8VWUbkhayMslid07DTbe0LpG
	Z5w==
X-Received: by 2002:a17:907:807:b0:c26:19de:912d with SMTP id
 a640c23a62f3a-c2619dea0a3mr112357266b.32.1788526957825; Fri, 04 Sep 2026
 06:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829-swap-pcp-priq-v2-resend-0-68d3d925578c@gmail.com>
 <appvhlPleahTRklV@yjaykim-PowerEdge-T330> <20260904100900.21517-1-lianux.mm@gmail.com>
In-Reply-To: <20260904100900.21517-1-lianux.mm@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 4 Sep 2026 21:02:00 +0800
X-Gm-Features: AcwNN1Vm-0llheBPana_0CljCj4L1V8rcsjZv3MdI7EdXVkr6QNxUdxDIn19Bb4
Message-ID: <CAMgjq7Bh0hdVoRcS4xMRL0YG-zmjh-TxyF9xXCmP2MRarAyksQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v2 00/13] mm/swap: introduce per-priority
 allocation queues
To: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>
Cc: Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Jihan LIN <linjh22s@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:12=E2=80=AFPM Lian Wang (ProcessMission)
<lianux.mm@gmail.com> wrote:
>
> On Fri, 4 Sep 2026 16:13:10 +0900 Youngjun Park <youngjun.park@lge.com> w=
rote:
>
> > Since tiers come up further down, I'd like to raise a point about the
> > patch subject line too. As Kairui mentioned in RFC v1 that we would
> > stay aligned with tiers, would it make sense to frame this RFC as a
> > per-tier allocation policy (or something along those lines)? Kairui,
> > what's your opinion?
>
> Thanks for the thoughtful feedback and for taking an initial pass over
> the series.
>
> I agree that this queue could naturally become an in-tier allocation
> policy. For this RFC, I would prefer to keep it separate and scoped to
> the existing priority semantics while the tier and virtual-swap
> directions are still being settled. We can revisit the subject and
> naming once that boundary is clearer.

Hi All!

We can start with adpating the default priority if tiering still needs
more time to land, Not changing the user interface means less risk.
It's also fine to implement tiering first, there are some other
blocking issues for tier though.

With tiering I think we will still need rotation of devices in the
same priorities / tier. Once tier is ready, we can further extend the
rotation in the same tier; that's something to discuss.

>
> I will also sync with Kairui when he has time. He has several things in
> flight, but his view on the ownership and framing would be valuable.
>
> > Devices assigned to the same tier already share the same priority, so

Hmm, the current posted tier is a band of priorities. Do you mean that
when tiering is enabled, devices in the same tier, despite of having
different priority, will be used equally? And is priority ineffective
then?

> > I don't think the allocation policy needs more than one option for
> > that case (I can't think of a use case that would need it).
> >
> > 1. For legacy swap with no tier configured, define it as a single
> >    priority treated as one tier.
> > 2. When priorities match, allocation naturally falls to a single
> >    policy (not a queue). the concrete policy here is this
> >    queue-based scheme.
> > 3. When tiers are enabled, devices previously assigned under legacy
> >    swap are reassigned to tiers at runtime.
> >    (This means different swap device on same tier handled like same pri=
ority device)
>
> These are useful design points. I would like to study the concrete v11
> before deciding between runtime, boot-time, or compile-time tier
> assignment. It seems safer not to bind this queue RFC to a permanent
> tier interface while those semantics and the virtual-swap backend model
> are still under discussion.
>
> > I think this feature will also be needed on the virtualized swap side,
> > which makes me wonder whether this patch should go back into the swap
> > tier series instead. Kairui, Lian, what do you think? (Or separately?)

I'm fine as long as there won't be a regression. I remember V10 of
tier didn't touch this yet so the regression is limited to tier
enabled case, so no existing case will experience any issue, that is
fine. Causing a performance regression for existing usecases is
usually a bad idea.
