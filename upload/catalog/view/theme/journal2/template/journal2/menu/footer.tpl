<?php foreach ($rows as $row): ?>
<?php if ($row['type'] === 'columns'): ?>
<div class="row columns">
    <?php foreach ($row['columns'] as $column): ?>
    <div class="column <?php echo $column['type']; ?> <?php echo $row['classes']; ?> <?php echo $column['title'] ? '' : 'no-title'; ?>">
        <?php if ($column['title']): ?>
        <h3><?php echo $column['title']; ?></h3>
        <?php endif; ?>
        <?php if($column['type'] === 'menu'): ?>
        <div class="column-menu-wrap">
        <ul>
            <?php foreach ($column['items'] as $item): ?>
            <?php if($item['href']): ?>
            <li><a href="<?php echo $item['href']; ?>"<?php echo $item['class']; ?><?php echo $item['target']; ?>><?php echo $item['icon_left']; ?><?php echo $item['name']; ?><?php echo $item['icon_right']; ?></a></li>
            <?php else: ?>
            <li><?php echo $item['target']; ?><?php echo $item['icon_left']; ?><?php echo $item['name']; ?><?php echo $item['icon_right']; ?></li>
            <?php endif; ?>
            <?php endforeach; ?>
        </ul>
        </div>
        <?php else: ?>
        <div class="column-text-wrap">
            <?php echo $column['text']; ?>
        </div>
        <?php endif; ?>
    </div>
    <?php endforeach; ?>
</div>
<?php endif; ?>
<?php if ($row['type'] === 'contacts'): ?>
<div class="row contacts">
    <?php if ($row['contacts']['left']): ?>
    <div class="contacts-left">
        <?php foreach ($row['contacts']['left'] as $contact): ?>
        <?php $no_text_class = $contact['name'] ? '' : 'class="no-name"' ; ?>
        <?php if ($contact['link']): ?>
        <span <?php echo $no_text_class; ?> <?php echo $contact['tooltip'] && $contact['name'] ? 'class="hint--top" data-hint="' . $contact['name'] .'"' : ''?>><a <?php echo $contact['target']; ?> href="<?php echo $contact['link']; ?>"><?php echo $contact['icon_left']; ?><span class="contacts-text"><?php echo !$contact['tooltip'] ? $contact['name'] : ''; ?></span><?php echo $contact['icon_right']; ?></a></span>
        <?php else: ?>
        <span <?php echo $no_text_class; ?> <?php echo $contact['tooltip'] && $contact['name']? 'class="hint--top" data-hint="' . $contact['name'] .'"' : ''?>><?php echo $contact['icon_left']; ?><span class="contacts-text"><?php echo !$contact['tooltip'] ? $contact['name'] : ''; ?></span><?php echo $contact['icon_right']; ?></span>
        <?php endif; ?>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
    <?php if ($row['contacts']['right']): ?>
    <div class="contacts-right">
        <?php foreach ($row['contacts']['right'] as $contact): ?>
        <?php $no_text_class = $contact['name'] ? '' : 'class="no-name"' ; ?>
        <?php if ($contact['link']): ?>
        <span <?php echo $no_text_class; ?> <?php echo $contact['tooltip'] && $contact['name'] ? 'class="hint--top" data-hint="' . $contact['name'] .'"' : ''?>><a <?php echo $contact['target']; ?> href="<?php echo $contact['link']; ?>"><?php echo $contact['icon_left']; ?><span class="contacts-text"><?php echo !$contact['tooltip'] ? $contact['name'] : ''; ?></span><?php echo $contact['icon_right']; ?></a></span>
        <?php else: ?>
        <span <?php echo $no_text_class; ?> <?php echo $contact['tooltip'] && $contact['name'] ? 'class="hint--top" data-hint="' . $contact['name'] .'"' : ''?>><?php echo $contact['icon_left']; ?><span class="contacts-text"><?php echo !$contact['tooltip'] ? $contact['name'] : ''; ?></span><?php echo $contact['icon_right']; ?></span>
        <?php endif; ?>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>
<?php endif; ?>
<?php endforeach; ?>
