Received: from lgeamrelo12.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3721A447
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745565; cv=none; b=shE4aeNf/gbr74GK7HYeSIpNi0t2XlI+Z+6zBurwHLLZuJv8ppXTEaBziNA8z1BBhDpLKkSVKO9moCCDfSTHe6F3ZO71+wjluXT603ApahGmDDUKNkwIdF9/orhaZ7j1ucIOXIut7Es9uE2yUfmCCSbb1yPkT3W2vuRu/ns4ucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745565; c=relaxed/simple;
	bh=Ukfzdh7BQaBlOzsk1ofwfB5Xf1gdNe4E+bFJl5cXSwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtyGWnQ2eWnmUrqejCeb3Nt1IXPDkZ5IxBiXBuhNlmmz1do3hohcYk6qv05DXPwIhpeopRb/KvPfZ0qPqd7d2gMwrwL4gGCrUQWmpdAvpb3Lt4SC7chDt+ibnWY/UOAO6ATZFmRBM/zS5dCiVylbjk5f4burZudiaDsonw52TS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.52 with ESMTP; 7 Sep 2026 10:45:53 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: youngjun.park@lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.1.126 with ESMTP; 7 Sep 2026 10:45:53 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Mon, 7 Sep 2026 10:45:53 +0900
From: Youngjun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Jihan LIN <linjh22s@gmail.com>, Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 00/13] mm/swap: introduce per-priority
 allocation queues
Message-ID: <ap4XUQtdLIITU5Dt@yjaykim-PowerEdge-T330>
References: <20260829-swap-pcp-priq-v2-resend-0-68d3d925578c@gmail.com>
 <appvhlPleahTRklV@yjaykim-PowerEdge-T330>
 <20260904100900.21517-1-lianux.mm@gmail.com>
 <CAMgjq7Bh0hdVoRcS4xMRL0YG-zmjh-TxyF9xXCmP2MRarAyksQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7Bh0hdVoRcS4xMRL0YG-zmjh-TxyF9xXCmP2MRarAyksQ@mail.gmail.com>

On Fri, Sep 04, 2026 at 09:02:00PM +0800, Kairui Song wrote:
> On Fri, Sep 4, 2026 at 6:12 PM Lian Wang (ProcessMission)
> <lianux.mm@gmail.com> wrote:
> >
> > On Fri, 4 Sep 2026 16:13:10 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> >
> > > Since tiers come up further down, I'd like to raise a point about the
> > > patch subject line too. As Kairui mentioned in RFC v1 that we would
> > > stay aligned with tiers, would it make sense to frame this RFC as a
> > > per-tier allocation policy (or something along those lines)? Kairui,
> > > what's your opinion?
> >
> > Thanks for the thoughtful feedback and for taking an initial pass over
> > the series.
> >
> > I agree that this queue could naturally become an in-tier allocation
> > policy. For this RFC, I would prefer to keep it separate and scoped to
> > the existing priority semantics while the tier and virtual-swap
> > directions are still being settled. We can revisit the subject and
> > naming once that boundary is clearer.
> 
> Hi All!
> 
> We can start with adpating the default priority if tiering still needs
> more time to land, Not changing the user interface means less risk.
> It's also fine to implement tiering first, there are some other
> blocking issues for tier though.
> 
> With tiering I think we will still need rotation of devices in the
> same priorities / tier. Once tier is ready, we can further extend the
> rotation in the same tier; that's something to discuss.
> 
> >
> > I will also sync with Kairui when he has time. He has several things in
> > flight, but his view on the ownership and framing would be valuable.
> >
> > > Devices assigned to the same tier already share the same priority, so
> 
> Hmm, the current posted tier is a band of priorities. Do you mean that
> when tiering is enabled, devices in the same tier, despite of having
> different priority, will be used equally? And is priority ineffective
> then?

Hello Kairui

Right. My thought is to remove the priority semantics within a tier.

Once devices are grouped into the same tier, allocation within that tier
should be handled by a tier-specific allocation policy.

If users want the traditional priority-based behavior, I think they should
assign devices to different tiers and manage them that way.

For swap devices assigned to the same tier, we can still leave the behavior
flexible through the interfac(they may be treated equally, or priority may
still be considered). However, there should be a default allocation policy.

> > > I don't think the allocation policy needs more than one option for
> > > that case (I can't think of a use case that would need it).
> > >
> > > 1. For legacy swap with no tier configured, define it as a single
> > >    priority treated as one tier.
> > > 2. When priorities match, allocation naturally falls to a single
> > >    policy (not a queue). the concrete policy here is this
> > >    queue-based scheme.
> > > 3. When tiers are enabled, devices previously assigned under legacy
> > >    swap are reassigned to tiers at runtime.
> > >    (This means different swap device on same tier handled like same priority device)
> >
> > These are useful design points. I would like to study the concrete v11
> > before deciding between runtime, boot-time, or compile-time tier
> > assignment. It seems safer not to bind this queue RFC to a permanent
> > tier interface while those semantics and the virtual-swap backend model
> > are still under discussion.
> >
> > > I think this feature will also be needed on the virtualized swap side,
> > > which makes me wonder whether this patch should go back into the swap
> > > tier series instead. Kairui, Lian, what do you think? (Or separately?)
> 
> I'm fine as long as there won't be a regression. I remember V10 of
> tier didn't touch this yet so the regression is limited to tier
> enabled case, so no existing case will experience any issue, that is
> fine. Causing a performance regression for existing usecases is
> usually a bad idea.

Yeah right. will consider regession case.

Thanks
